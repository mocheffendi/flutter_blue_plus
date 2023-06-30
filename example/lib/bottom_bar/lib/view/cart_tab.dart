import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:iconly/iconly.dart';

import '../sensor/homeui.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  // const CartTab({super.key, required this._mainWrapperController});
  late BluetoothDevice targetdevice;
  String macAddress = "24:0A:C4:09:B9:0A";
  String serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  // ignore: non_constant_identifier_names
  String charaCteristic_uuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  late bool isReady;
  late Stream<List<int>> stream;
  late List _temphumidata;
  double _temp = 0;
  double _humidity = 0;

  @override
  void initState() {
    // controller = AnimationController(
    //   /// [AnimationController]s can be created with `vsync: this` because of
    //   /// [TickerProviderStateMixin].
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // )..addListener(() {
    //     setState(() {});
    //   });
    // controller.repeat(reverse: true);
    super.initState();
    isReady = false;
    connectToDevice();
  }

  @override
  void dispose() {
    // controller.dispose();
    targetdevice.disconnect();
    super.dispose();
  }

  connectToDevice() async {
    // ignore: unnecessary_null_comparison

    targetdevice = BluetoothDevice.fromId(macAddress);

    // if (targetdevice == null) {
    //   // _pop();
    //   return;
    // }

    Timer(const Duration(seconds: 15), () {
      if (!isReady) {
        disconnectFromDevice();
        // _pop();
      }
    });

    await targetdevice.connect();
    discoverServices();
  }

  disconnectFromDevice() {
    // ignore: unnecessary_null_comparison
    if (targetdevice == null) {
      // _pop();
      return;
    }

    targetdevice.disconnect();
  }

  discoverServices() async {
    // ignore: unnecessary_null_comparison
    if (targetdevice == null) {
      // _pop();
      return;
    }

    List<BluetoothService> services = await targetdevice.discoverServices();
    for (var service in services) {
      if (service.uuid.toString() == serviceUuid) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == charaCteristic_uuid) {
            characteristic.setNotifyValue(!characteristic.isNotifying);
            stream = characteristic.value;

            setState(() {
              isReady = true;
            });
          }
        }
      }
    }

    if (!isReady) {
      // _pop();
    }
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to disconnect device and go back?'),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No')),
          ElevatedButton(
              onPressed: () {
                disconnectFromDevice();
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes')),
        ],
      ),
    );
  }

  // _pop() {
  //   Navigator.of(context).pop(true);
  // }

  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  // Future<bool> _onClose() async {
  //   return await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: const Text('Alert'),
  //             content: const Text('Voulez vous quitter l\'application ?'),
  //             actions: [
  //               TextButton(
  //                   onPressed: () {
  //                     // if (Platform.isAndroid) {
  //                     //   SystemNavigator.pop();
  //                     // } else if (Platform.isIOS) {
  //                     //   exit(0);
  //                     // }
  //                   },
  //                   child: const Text('Oui')),
  //               TextButton(
  //                   onPressed: () => Navigator.of(context).pop(false),
  //                   child: const Text('Non'))
  //             ],
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hilux | Temperature Sensor'),
        ),
        body: Container(
            child: !isReady
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : StreamBuilder<List<int>>(
                    stream: stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<int>> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.active) {
                        // geting data from bluetooth
                        var currentValue = _dataParser(snapshot.requireData);
                        _temphumidata = currentValue.split(",");
                        if (_temphumidata[0] != "nan") {
                          _temp = double.parse('${_temphumidata[0]}');
                        }
                        if (_temphumidata[1] != "nan") {
                          _humidity = double.parse('${_temphumidata[1]}');
                        }
                        return HomeUI(
                          humidity: _humidity,
                          temperature: _temp,
                        );
                      } else {
                        return const Text('Check the stream');
                      }
                    },
                  )),
      ),
    );
  }
}
