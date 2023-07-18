import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:map_app/map/map.dart';

import 'package:map_app/map/widgets/pin/pin.dart';

class PinWidget extends StatefulWidget {
  const PinWidget({super.key});

  @override
  State<PinWidget> createState() => _PinWidgetState();
}

class _PinWidgetState extends State<PinWidget> {
  late final ValueNotifier<bool> _isMoving;

  @override
  void initState() {
    super.initState();
    _isMoving = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    const size = 60.0;
    return BlocListener<MapCubit, MapState>(
      listenWhen: (previous, current) => previous.isMoving != current.isMoving,
      listener: (context, state) {
        _isMoving.value = state.isMoving;
      },
      child: SizedBox(
        height: size,
        child: ValueListenableBuilder(
          valueListenable: _isMoving,
          builder: (context, moiving, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                    bottom: !moiving ? 0 : (size * 0.3),
                  ),
                  child: const PinIcon(),
                ),
                if (moiving)
                  Container(
                    padding: const EdgeInsets.only(top: size * 1.2),
                    child: Transform(
                      transform: Matrix4.rotationX(2),
                      child: Container(
                        width: size * 0.1,
                        height: size * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _isMoving.dispose();
  }
}
