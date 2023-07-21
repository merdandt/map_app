import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:map_app/map/map.dart';

import 'package:map_app_ui/map_app_ui.dart';

class PinWidget extends StatelessWidget {
  const PinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const size = UISpacing.pinH;
    final isMoving = context.select<MapCubit, bool>(
      (cubit) => cubit.state.isMoving,
    );
    return SizedBox(
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.only(
              bottom: !isMoving ? 0 : (size * 0.3),
            ),
            child: const PinIcon(),
          ),
          if (isMoving)
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
      ),
    );
  }
}
