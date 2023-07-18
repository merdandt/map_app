import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:map_app/decoder/cubit/decoder_cubit.dart';
import 'package:map_app/decoder/view/decoder_body.dart';
import 'package:map_repository/map_repository.dart';

class DecoderWidget extends StatelessWidget {
  const DecoderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DecodedCubit(context.read<MapRepository>()),
      child: const DecoderBody(),
    );
  }
}
