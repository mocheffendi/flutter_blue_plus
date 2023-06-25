// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

String getInitials(String bleName) {
  return bleName.isNotEmpty
      ? bleName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
}

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.isNotEmpty) {
      return Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                result.device.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                result.device.id.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                result.rssi.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          Container(width: 2, color: Colors.black), // This is divider
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  Widget _buildTrailing(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(80, 60), // button width and height
      child: Row(
        children: [
          Container(
            width: 1,
            color: const Color.fromARGB(255, 128, 128, 128),
            margin: const EdgeInsets.only(right: 20.0),
          ), // This is divider
          Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: Colors.green, // splash color
              onTap: (result.advertisementData.connectable)
                  ? onTap
                  : null, // button pressed
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.phonelink_setup,
                    size: 28,
                  ), // icon
                  Text("Connect",
                      style: TextStyle(fontWeight: FontWeight.bold)), // text
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 168, 168, 168),
        border: Border.all(
            width: 1, color: const Color.fromARGB(255, 168, 168, 168)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
          title: _buildTitle(context),
          leading: CircleAvatar(child: Text(getInitials(result.device.name))),
          // trailing: ElevatedButton(
          //   child: const Text('CONNECT'),
          //   style: ElevatedButton.styleFrom(
          //     foregroundColor: Colors.white,
          //     backgroundColor: Colors.black,
          //   ),
          //   onPressed: (result.advertisementData.connectable) ? onTap : null,
          // ),
          // trailing: InkWell(
          //   onTap: () {},
          //   child: Material(
          //     elevation: 5,
          //     child: Container(
          //       width: 48,
          //       height: 48,
          //       decoration: const BoxDecoration(
          //           color: Colors.blueAccent,
          //           borderRadius: BorderRadius.all(Radius.circular(8))),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           IconButton(
          //               padding: const EdgeInsets.all(0),
          //               onPressed:
          //                   (result.advertisementData.connectable) ? onTap : null,
          //               icon: const Icon(Icons.favorite)),
          //           const Text('Connect'),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // trailing: TextButton.icon(
          //   onPressed: (result.advertisementData.connectable) ? onTap : null,
          //   icon: const Icon(Icons.delete),
          //   label: const Text('Delete item'),
          // ),
          children: <Widget>[
            _buildAdvRow(context, 'Complete Local Name',
                result.advertisementData.localName),
            _buildAdvRow(context, 'Tx Power Level',
                '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
            _buildAdvRow(
                context,
                'Manufacturer Data',
                getNiceManufacturerData(
                    result.advertisementData.manufacturerData)),
            _buildAdvRow(
                context,
                'Service UUIDs',
                (result.advertisementData.serviceUuids.isNotEmpty)
                    ? result.advertisementData.serviceUuids
                        .join(', ')
                        .toUpperCase()
                    : 'N/A'),
            _buildAdvRow(context, 'Service Data',
                getNiceServiceData(result.advertisementData.serviceData)),
          ],
          trailing: _buildTrailing(context)),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile(
      {Key? key, required this.service, required this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.isNotEmpty) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Service'),
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color))
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: const Text('Service'),
        subtitle:
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;

  const CharacteristicTile(
      {Key? key,
      required this.characteristic,
      required this.descriptorTiles,
      this.onReadPressed,
      this.onWritePressed,
      this.onNotificationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Characteristic'),
                Text(
                    '0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color))
              ],
            ),
            subtitle: Text(value.toString()),
            contentPadding: const EdgeInsets.all(0.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                ),
                onPressed: onReadPressed,
              ),
              IconButton(
                icon: Icon(Icons.file_upload,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onWritePressed,
              ),
              IconButton(
                icon: Icon(
                    characteristic.isNotifying
                        ? Icons.sync_disabled
                        : Icons.sync,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onNotificationPressed,
              )
            ],
          ),
          children: descriptorTiles,
        );
      },
    );
  }
}

class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;

  const DescriptorTile(
      {Key? key,
      required this.descriptor,
      this.onReadPressed,
      this.onWritePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Descriptor'),
          Text('0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color))
        ],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) => Text(snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          )
        ],
      ),
    );
  }
}

class AdapterStateTile extends StatelessWidget {
  const AdapterStateTile({Key? key, required this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: ListTile(
        title: Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.titleSmall,
        ),
        trailing: Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.titleSmall?.color,
        ),
      ),
    );
  }
}
