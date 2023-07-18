import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/map/map.dart';
import 'package:map_repository/map_repository.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = MapRepository();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBloc(_repository),
      child: const MapView(),
    );
  }
}
