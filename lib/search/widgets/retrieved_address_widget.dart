import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/map/map.dart';
import 'package:map_app/search/bloc/search_bloc.dart';
import 'package:map_app_ui/map_app_ui.dart';
import 'package:map_repository/map_repository.dart';

class RetriviedWidget extends StatelessWidget {
  const RetriviedWidget({
    required this.address,
    super.key,
  });
  final RetrievedAddress address;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<SearchBloc>().add(
                const SearchCleared(),
              );
          context.read<MapCubit>().locateToThePoint(
                address.latlng,
              );
        },
        child: Row(
          children: [
            Container(
              margin: UISpacing.lg.edgeInsetsSymmetric(h: true),
              alignment: Alignment.centerLeft,
              width: UISpacing.xlg,
              child: const Icon(
                Icons.location_pin,
                size: 22,
                color: UIColors.blue,
              ),
            ),
            Expanded(
              child: Text(
                address.displayName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.bodyText1.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: UIColors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    ).paddingSymmetric(v: UISpacing.md);
  }
}
