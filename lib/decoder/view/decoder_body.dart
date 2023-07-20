import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/decoder/cubit/decoder_cubit.dart';
import 'package:map_app/map/map.dart';
import 'package:map_app_ui/map_app_ui.dart';
import 'package:map_repository/map_repository.dart';

class DecoderBody extends StatefulWidget {
  const DecoderBody({super.key});

  @override
  State<DecoderBody> createState() => _DecoderBodyState();
}

class _DecoderBodyState extends State<DecoderBody> {
  late final ValueNotifier<bool> _isMoving;

  LatLng _latLng = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _isMoving = ValueNotifier(false);
  }

  Widget bodyContainer(Widget child) => Container(
        padding: const EdgeInsets.all(5),
        height: UISpacing.decoderH,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape: ArrowMiddleBottomShape(),
          color: Colors.white,
          shadows: UIShadows.midShadow,
        ),
        child: child,
      );

  void fetchGeoCoding(LatLng latLng) =>
      context.read<DecodedCubit>().fetchGeoCoding(latLng);

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.sizeOf(context).height;
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return BlocListener<MapCubit, MapState>(
      listenWhen: (previous, current) =>
          previous.isMoving != current.isMoving ||
          previous.position != current.position,
      listener: (context, mapState) {
        _isMoving.value = mapState.isMoving;
        if (!_isMoving.value) {
          _latLng = mapState.position;
          fetchGeoCoding(_latLng);
        }
      },
      child: BlocBuilder<DecodedCubit, DecoderState>(
        builder: (context, state) {
          return Center(
            child: ValueListenableBuilder(
              valueListenable: _isMoving,
              builder: (context, value, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                    left: mediaWidth * .2,
                    right: mediaWidth * .2,
                    bottom: value ? mediaHeight : 140,
                  ),
                  child: switch (state.status) {
                    DecoderStaus.loading => bodyContainer(
                        const CupertinoActivityIndicator(),
                      ),
                    DecoderStaus.failure => bodyContainer(
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            fetchGeoCoding(_latLng);
                          },
                        ),
                      ),
                    DecoderStaus.initial => const SizedBox(),
                    DecoderStaus.success => bodyContainer(
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: UITextStyle.bodyText2,
                        ),
                      )
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _isMoving.dispose();
  }
}
