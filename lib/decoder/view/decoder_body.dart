import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/decoder/cubit/decoder_cubit.dart';
import 'package:map_app/decoder/helpers/helpers.dart';
import 'package:map_app/map/map.dart';
import 'package:map_app_ui/map_app_ui.dart';

class DecoderBody extends StatefulWidget {
  const DecoderBody({super.key});

  @override
  State<DecoderBody> createState() => _DecoderBodyState();
}

class _DecoderBodyState extends State<DecoderBody> {
  late final ValueNotifier<bool> _isMoving;

  @override
  void initState() {
    super.initState();
    _isMoving = ValueNotifier(false);
  }

  Widget bodyContainer(Widget child) => Container(
        padding: const EdgeInsets.all(5),
        height: 100,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape: ArrowMiddleBottomShape(),
          color: Colors.white,
          shadows: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.sizeOf(context).height;
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return BlocListener<MapCubit, MapState>(
      listenWhen: (previous, current) => previous.isMoving != current.isMoving,
      listener: (context, state) {
        _isMoving.value = state.isMoving;
        if (!_isMoving.value) {
          context.read<DecodedCubit>().fetchNominat(state.position);
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
                    DecoderStaus.loading =>
                      bodyContainer(const CupertinoActivityIndicator()),
                    DecoderStaus.failure => IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {},
                      ),
                    DecoderStaus.initial => const SizedBox(),
                    DecoderStaus.success => bodyContainer(
                        Text(
                          state.message,
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
