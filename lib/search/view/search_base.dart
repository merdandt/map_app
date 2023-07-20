import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/search/search.dart';
import 'package:map_app/search/widgets/retrieved_address_widget.dart';
import 'package:map_app_ui/map_app_ui.dart';

class SearchBase extends StatefulWidget {
  const SearchBase({super.key});

  @override
  State<SearchBase> createState() => _SearchBaseState();
}

class _SearchBaseState extends State<SearchBase> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void searchStreet(String value) {
    context.read<SearchBloc>().add(StreetSearched(value));
  }

  void clearSearch() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
    context.read<SearchBloc>().add(const SearchCleared());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: UISpacing.lg,
      right: UISpacing.lg,
      top: UISpacing.decoderH,
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
                UITextField.search(
                  controller: _searchController,
                  contentPadding: UISpacing.md.edgeInsetsAll(),
                  onChanged: searchStreet,
                  onSubmitted: searchStreet,
                  prefix: switch (state.status) {
                    SearchStatus.initial => const Icon(
                        Icons.search,
                        color: UIColors.grey,
                      ).paddingSymmetric(h: UISpacing.md),
                    SearchStatus.loaading => const CupertinoActivityIndicator()
                        .paddingSymmetric(h: UISpacing.md),
                    SearchStatus.success => const Icon(
                        Icons.search,
                        color: UIColors.grey,
                      ).paddingSymmetric(h: UISpacing.md),
                    SearchStatus.failure => const Icon(
                        Icons.wrong_location_outlined,
                        color: UIColors.red,
                      ).paddingSymmetric(h: UISpacing.md),
                  },
                  suffix: list.isEmpty && _searchController.text.isEmpty
                      ? const SizedBox()
                      : IconButton(
                          onPressed: clearSearch,
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                ).paddingOnly(
                  right: UISpacing.md,
                ),
                Expanded(
                  child: AnimatedCrossFade(
                    crossFadeState: list.isEmpty
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
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
                              callBack: clearSearch,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
}
