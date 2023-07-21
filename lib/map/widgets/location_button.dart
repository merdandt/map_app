import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/map/map.dart';
import 'package:map_app_ui/map_app_ui.dart';

class LocatorButton extends StatelessWidget {
  const LocatorButton({super.key});

  Widget locationWidget({
    required Widget child,
    void Function()? onTap,
  }) {
    return FloatingActionButton(
      onPressed: onTap,
      child: child,
    );
  }

  void locateDevice(BuildContext context) {
    context.read<MapCubit>().locateDevice();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMoving = context.select<MapCubit, bool>(
      (cubit) => cubit.state.isMoving,
    );
    return AnimatedPositioned(
      bottom: UISpacing.xxxlg,
      right: isMoving ? -UISpacing.xxxxlg : UISpacing.xxlg,
      duration: const Duration(milliseconds: 300),
      child: BlocBuilder<MapCubit, MapState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return switch (state.status) {
            LocationStaus.initial => const SizedBox(),
            LocationStaus.loading => locationWidget(
                child: const CircularProgressIndicator(),
              ),
            LocationStaus.failure => locationWidget(
                onTap: () => locateDevice(context),
                child: theme.icons.refresh(),
              ),
            LocationStaus.success => locationWidget(
                onTap: () => locateDevice(context),
                child: theme.icons.location(
                  size: UISpacing.xlg,
                  color: UIColors.white,
                ),
              )
          };
        },
      ),
    );
  }
}
