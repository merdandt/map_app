import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_app/map/helpers/helpers.dart';
import 'package:map_app/map/map.dart';
import 'package:map_repository/map_repository.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final MapController _mapController;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  LatLng? positionMapFocus;

  @override
  Widget build(BuildContext context) {
    positionMapFocus = context.watch<MapCubit>().state.position;
    return Positioned.fill(
      child: BlocListener<MapCubit, MapState>(
        listenWhen: (previous, current) =>
            previous.position != current.position,
        listener: (context, state) {
          positionMapFocus = state.position;
          _mapController.move(positionMapFocus!, state.zoom);
        },
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            maxZoom: 18,
            onMapEvent: (event) {
              if (event is MapEventMoveStart) {
                context.read<MapCubit>().startMoving();
              } else if (event is MapEventMoveEnd) {
                context.read<MapCubit>().endMoving(
                      positionMapFocus!,
                      _mapController.zoom,
                    );
              }
            },
            zoom: context.watch<MapCubit>().state.zoom,
            keepAlive: true,
            onPositionChanged: (position, hasGesture) {
              positionMapFocus = position.center;
            },
            center: positionMapFocus,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://geo.asmanexpress.com/tile/{z}/{x}/{y}.png',
              // urlTemplate: MapRepository.urlTemplate,
              tileProvider: CachedTileProvider(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
  }
}
