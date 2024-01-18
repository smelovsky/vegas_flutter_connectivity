import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

class AccessPointTile extends StatefulWidget {
  final WiFiAccessPoint accessPoint;

  const AccessPointTile({Key? key, required this.accessPoint}) : super(key: key);

  @override
  State<AccessPointTile> createState() => _AccessPointTileState(accessPoint: accessPoint);
}

class _AccessPointTileState extends State<AccessPointTile> {

  _AccessPointTileState({required this.accessPoint});

  WiFiAccessPoint accessPoint;
  String _password = "123456789";

  @override
  void initState() {
    super.initState();

    // print("init");
  }

  Widget _buildInfo(String label, dynamic value) => Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    child: Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(value.toString()))
      ],
    ),
  );

  Widget _buildActions(BuildContext context, String ssid) => Container(

    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          child: const Text('Connect'),
          onPressed: (  )  {
            WiFiForIoTPlugin.connect(
                ssid,
                password: _password,
                joinOnce: true,
                security: NetworkSecurity.WPA);
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),

        TextButton(
          child: const Text('Disconnect'),
          onPressed: ()  {
            WiFiForIoTPlugin.disconnect();
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),

      ],
    ),
  );

  Widget _buildPassword(BuildContext context) => Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    child: Row(
      children: [
        Text(
          "Password: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: TextFormField(
          initialValue: _password,
          style: TextStyle(fontSize: 22),
          onChanged: (value) {
            print("PW: ${value}");
            setState(() {
              _password = value;
            });
          },
        )
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final title = accessPoint.ssid.isNotEmpty ? accessPoint.ssid : "**EMPTY**";
    final signalIcon = accessPoint.level >= -80
        ? Icons.signal_wifi_4_bar
        : Icons.signal_wifi_0_bar;

    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(signalIcon),
      title: Text(title),
      subtitle: Text(accessPoint.capabilities),

      onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Action"),
            content: Column (
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInfo("SSDI", accessPoint.ssid),
                _buildPassword(context),
                _buildActions(context, accessPoint.ssid),
              ],
            ),
          )
      ),

      onLongPress: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfo("BSSDI", accessPoint.bssid),
              _buildInfo("Capability", accessPoint.capabilities),
              _buildInfo("frequency", "${accessPoint.frequency}MHz"),
              _buildInfo("level", accessPoint.level),
              _buildInfo("standard", accessPoint.standard),
              _buildInfo(
                  "centerFrequency0", "${accessPoint.centerFrequency0}MHz"),
              _buildInfo(
                  "centerFrequency1", "${accessPoint.centerFrequency1}MHz"),
              _buildInfo("channelWidth", accessPoint.channelWidth),
              _buildInfo("isPasspoint", accessPoint.isPasspoint),
              _buildInfo(
                  "operatorFriendlyName", accessPoint.operatorFriendlyName),
              _buildInfo("venueName", accessPoint.venueName),
              _buildInfo("is80211mcResponder", accessPoint.is80211mcResponder),
            ],
          ),
        ),
      ),

    );
  }
}
