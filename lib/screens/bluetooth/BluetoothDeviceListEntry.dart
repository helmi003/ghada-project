// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:ghada/utils/colors.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final BluetoothDevice device;
  final int? rssi;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool enabled;
  const BluetoothDeviceListEntry({
    required this.device,
    this.rssi,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        enabled: enabled,
        leading: Icon(Icons.devices, color: warmBlueColor),
        title: Text(
          device.name ?? "",
          style: TextStyle(color: warmBlueColor),
        ),
        subtitle: Text(device.address.toString(),
            style: TextStyle(color: warmBlueColor)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            rssi != null
                ? Container(
                    margin: EdgeInsets.all(8.0),
                    child: DefaultTextStyle(
                      style: _computeTextStyle(rssi!),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(rssi.toString(),
                              style: TextStyle(color: warmBlueColor)),
                          Text('dBm', style: TextStyle(color: warmBlueColor)),
                        ],
                      ),
                    ),
                  )
                : Container(width: 0, height: 0),
            device.isConnected
                ? Icon(Icons.import_export, color: warmBlueColor)
                : Container(width: 0, height: 0),
            device.isBonded
                ? Icon(Icons.link, color: warmBlueColor)
                : Container(width: 0, height: 0),
          ],
        ),
      ),
    );
  }

  static TextStyle _computeTextStyle(int rssi) {
    /**/ if (rssi >= -35)
      return TextStyle(color: Colors.greenAccent[700]);
    else if (rssi >= -45)
      return TextStyle(
          color: Color.lerp(
              Colors.greenAccent[700], Colors.lightGreen, -(rssi + 35) / 10));
    else if (rssi >= -55)
      return TextStyle(
          color: Color.lerp(
              Colors.lightGreen, Colors.lime[600], -(rssi + 45) / 10));
    else if (rssi >= -65)
      return TextStyle(
          color: Color.lerp(Colors.lime[600], Colors.amber, -(rssi + 55) / 10));
    else if (rssi >= -75)
      return TextStyle(
          color: Color.lerp(
              Colors.amber, Colors.deepOrangeAccent, -(rssi + 65) / 10));
    else if (rssi >= -85)
      return TextStyle(
          color: Color.lerp(
              Colors.deepOrangeAccent, Colors.redAccent, -(rssi + 75) / 10));
    else
      /*code symmetry*/
      return TextStyle(color: Colors.redAccent);
  }
}
