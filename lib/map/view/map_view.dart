import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:map_app/decoder/decoder.dart';
import 'package:map_app/map/map.dart';
import 'package:map_app/map/widgets/map_widget.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

class MapView extends StatelessWidget {
  const MapView({super.key});
  @override
  Widget build(BuildContext context) {
    //final l10 = context.l10n;

    return const Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     l10.tapToNavigate,
      //     style: UITextStyle.bodyText1,
      //   ),
      // ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          MapWidget(),
          DecoderWidget(),
          PinWidget(),
          LocatorButton(),
        ],
      ),
    );
  }
}
