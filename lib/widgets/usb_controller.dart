import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';
import 'dart:typed_data'; //for Uint8list

class UsbController extends StatefulWidget {
  const UsbController({super.key});

  @override
  State<UsbController> createState() => _UsbControllerState();
}

class _UsbControllerState extends State<UsbController>{
  //what data do we need to track?
  bool isConnected = false; //are we connected?
  String status = 'Disconnected'; //what;s happening?
  List<UsbDevice> availableDevices = []; //list of found devices
  UsbPort? port; //add ts to store connecte dport
  int sliderValue = 0; //slider position

  //what can we do?
  void findDevices() async {
    //ask android for devices
    setState(() => status = "Searching for devices...");

    //from the usb_serial package:
    List<UsbDevice> devices = await UsbSerial.listDevices();

    setState(() {
      availableDevices = devices;
      status = "Found ${devices.length} devices";
    });
  }

  void connectToDevice(UsbDevice device) async {
    //try to connect to specific device
    setState(() => status = "Connecting to ${device.productName}...");
    
    //store port here
    port = await device.create();

    //try to open connection
    bool connected = await port!.open();

    if (connected) {
      _startListening();
      setState((){
        isConnected = true;
        status = "Connected to ${device.productName}";
      });
    } else {
      setState(() =>
      status = "Failed to connect to ${device.productName}"
      );
    }


  }

  void _startListening() {
    //listen for data from pico
    port!.inputStream!.listen(
      (Uint8List data) {
        //success callback
        String response = String.fromCharCodes(data).trim();
        setState(() {
          String picoResponse = response;
          status = "Pico: $picoResponse";
        });
      },
      onError: (error) {
        print("USB ERROR: $error");
        setState(() => status = "USB ERROR: $error");
      },
    );
  }

  void sendCommand(String command) async { //not need port param, use state var
    //send data to device
    if (!isConnected || port == null) {
      setState(() => status = "Not connected!");
      return;
    }

    //convert string to bytes and send
    Uint8List bytes = Uint8List.fromList("$command\n".codeUnits);
    port!.write(bytes);
    print("Sent: $command");
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        //status display
        Text(status),

        //conn butt
        if (!isConnected)
          ElevatedButton(
            onPressed: findDevices,
            child: Text('Find USB Devices'),
          ),

        //device list (show after searching)
        if (availableDevices.isNotEmpty && !isConnected)
          Column(
            children:
              availableDevices.map((device) => //fix map syntax dumb bitch
              ListTile( //ListTile not ListTitle you idiot
                title: Text(device.productName ?? "Unknown"),
                subtitle: Text("ID: ${device.deviceId}"),
                onTap: () => connectToDevice(device),
              )).toList() //we up we fix
          ),
        
        //controls (only show when connected)
        if (isConnected) ...[ //...[] spread operator, like ima spread your legs
          Slider(
            value: sliderValue.toDouble(), //use the var not fixed
            onChanged: (value) {
              setState(() => sliderValue = value.round()); //update slider position
              sendCommand("SET-$sliderValue");
            },
            min: 0,
            max: 100,
          ),
          ElevatedButton(
            onPressed: () => sendCommand("CALIBRATE"), //no port param needed
            child: Text("Calibrate Servo")
          )
        ]
      ],
    );
  }
}