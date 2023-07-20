import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/search/bloc/search_bloc.dart';
import 'package:map_app/search/view/search_base.dart';
import 'package:map_repository/map_repository.dart';

class SerachWidget extends StatelessWidget {
  const SerachWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(context.read<MapRepository>()),
      child: const SearchBase(),
    );
  }
}
