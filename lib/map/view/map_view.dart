import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:map_app/decoder/view/decoder_widget.dart';
import 'package:map_app/l10n/l10n.dart';
import 'package:map_app/map/map.dart';
import 'package:map_app/map/widgets/map_widget.dart';
import 'package:map_app_ui/map_app_ui.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

class MapView extends StatelessWidget {
  const MapView({super.key});
  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10.tapToNavigate,
          style: UITextStyle.headline3,
        ),
      ),
      body: const Stack(
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
