
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vegas_flutter_connectivity/player/PlayerPage.dart';
import 'package:vegas_flutter_connectivity/wifi/wifi_notifier.dart';
import 'package:vegas_flutter_connectivity/wifi/wifi_scan_get.dart';
import 'package:wifi_iot/wifi_iot.dart';

import 'access_point_tile.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(ref, context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Network connection monitor"),
    );
  }

  Center buildBody(WidgetRef ref, BuildContext context) {
    return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: double.infinity, height: double.infinity),
          child: Center(child:
            Column(
                children: <Widget>[

                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Enable/Disable WiFi with settings'),
                    onPressed: ()  {

                      WiFiForIoTPlugin.setEnabled(
                          true,
                          shouldOpenSettings: true);

                    },
                  ),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Scan WiFi access points'),
                    onPressed: () async {

                      startScan(ref);
                      getScannedResults(ref);

                    },
                  ),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Streaming'),

                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => PlayerPage()
                      ));
                    },


                  ),

                  Text(ref.watch(WiFiScanErrorProvider).error),
                  Text(ref.watch(WiFiGetErrorProvider).error),

                  const Divider(),
                  Flexible(
                    child:
                    Center(
                      child: ref.watch(WiFiAccessPointProvider).accessPoints.isEmpty
                          ? const Text("NO SCANNED RESULTS")
                          :
                      ListView.builder(
                          itemCount: ref.read(WiFiAccessPointProvider).accessPoints.length,
                          itemBuilder: (context, i) =>
                              AccessPointTile(accessPoint: ref.read(WiFiAccessPointProvider).accessPoints[i])),
                    ),
                  ),


              ],

            )
          )
        )
    );
  }


}