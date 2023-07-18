import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_app/decoder/view/decoder_widget.dart';
import 'package:map_app/map/helpers/helpers.dart';
import 'package:map_app/map/map.dart';
import 'package:map_app/map/widgets/pin/pin.dart';
import 'package:map_repository/map_repository.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapController _mapController;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  LatLng? positionMapFocus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          // Map
          Positioned.fill(
            child: BlocBuilder<MapCubit, MapState>(
              buildWhen: (previous, current) =>
                  previous.position != current.position,
              builder: (context, state) {
                positionMapFocus = state.position;
                return FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    onMapEvent: (event) {
                      if (event is MapEventMoveStart) {
                        context.read<MapCubit>().startMoving();
                      } else if (event is MapEventMoveEnd) {
                        context.read<MapCubit>().endMoving(positionMapFocus!);
                      }
                    },
                    zoom: 14,
                    keepAlive: true,
                    onPositionChanged: (position, hasGesture) {
                      positionMapFocus = position.center;
                    },
                    center: positionMapFocus,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://geo.asmanexpress.com/tile/{z}/{x}/{y}.png',
                      // urlTemplate: MapRepository.urlTemplate,
                      tileProvider: CachedTileProvider(),
                    ),
                  ],
                );
              },
            ),
          ),
          const DecoderWidget(),
          const PinWidget(),
        ],
      ),
    );
  }
}
