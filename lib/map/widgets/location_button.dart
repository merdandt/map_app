import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/map/map.dart';
import 'package:map_app_ui/map_app_ui.dart';

class LocatorButton extends StatefulWidget {
  const LocatorButton({super.key});

  @override
  State<LocatorButton> createState() => _LocatorButtonState();
}

class _LocatorButtonState extends State<LocatorButton> {
  late final ValueNotifier<bool> _isMoving;

  @override
  void initState() {
    super.initState();
    _isMoving = ValueNotifier(false);
  }

  Widget locationWidget({
    required Widget child,
    void Function()? onTap,
  }) {
    return FloatingActionButton(
      onPressed: onTap,
      child: child,
    );
  }

  void locateDevice() {
    context.read<MapCubit>().locateDevice();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<MapCubit, MapState>(
      listenWhen: (previous, current) => previous.isMoving != current.isMoving,
      listener: (context, state) {
        _isMoving.value = state.isMoving;
      },
      child: ValueListenableBuilder(
        valueListenable: _isMoving,
        builder: (context, value, child) {
          return AnimatedPositioned(
            bottom: UISpacing.xxxlg,
            right: value ? -UISpacing.xxxxlg : UISpacing.xxlg,
            duration: const Duration(milliseconds: 300),
            child: BlocBuilder<MapCubit, MapState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return switch (state.status) {
                  LocationStaus.initial => const SizedBox(),
                  LocationStaus.loading => locationWidget(
                      child: const CircularProgressIndicator(),
                    ),
                  LocationStaus.failure => locationWidget(
                      onTap: locateDevice,
                      child: theme.icons.refresh(),
                    ),
                  LocationStaus.success => locationWidget(
                      onTap: locateDevice,
                      child: theme.icons.location(
                        size: UISpacing.xlg,
                        color: UIColors.white,
                      ),
                    )
                };
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
