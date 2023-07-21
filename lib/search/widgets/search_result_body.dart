import 'package:flutter/material.dart';
import 'package:map_app/search/widgets/retrieved_address_widget.dart';
import 'package:map_repository/map_repository.dart';

class SearchResultBody extends StatelessWidget {
  const SearchResultBody({required this.list, super.key});
  final List<RetrievedAddress> list;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          list.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 900),
      reverseDuration: Duration.zero,
      sizeCurve: Curves.fastLinearToSlowEaseIn,
      firstChild: const SizedBox(),
      secondChild: SingleChildScrollView(
        child: Column(
          children: [
            ...list.map(
              (e) => RetriviedWidget(
                address: e,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
