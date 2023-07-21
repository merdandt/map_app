import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/map/cubit/map_cubit.dart';
import 'package:map_app/search/search.dart';
import 'package:map_app/search/widgets/widgets.dart';
import 'package:map_app_ui/map_app_ui.dart';

class SearchBase extends StatefulWidget {
  const SearchBase({super.key});

  @override
  State<SearchBase> createState() => _SearchBaseState();
}

class _SearchBaseState extends State<SearchBase> {
  @override
  Widget build(BuildContext context) {
    final isMoving = context.select<MapCubit, bool>(
      (bloc) => bloc.state.isMoving,
    );
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: UISpacing.lg,
      right: UISpacing.lg,
      top: isMoving ? -UISpacing.decoderH : UISpacing.xxxxlg,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          final maxHeight = MediaQuery.of(context).size.height * .5;
          const minHeight = 60.0;
          var expandedHeigt = maxHeight;
          final list = [...state.searchResult];
          if (list.length < (maxHeight ~/ minHeight)) {
            expandedHeigt = list.length * minHeight;
          } else {
            expandedHeigt = maxHeight;
          }
          return AnimatedContainer(
            height: list.isEmpty ? 50 : expandedHeigt,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 900),
            decoration: BoxDecoration(
              color: UIColors.white,
              borderRadius: list.isEmpty ? UIRadius.round : UIRadius.small,
              boxShadow: UIShadows.midShadow,
            ),
            child: Column(
              children: [
                const SearchHeader(),
                Expanded(
                  child: SearchResultBody(list: list),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
