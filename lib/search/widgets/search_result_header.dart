import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/search/search.dart';
import 'package:map_app_ui/map_app_ui.dart';

class SearchHeader extends StatefulWidget {
  const SearchHeader({super.key});

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void searchStreet(String value) {
    context.read<SearchBloc>().add(StreetSearched(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SearchStatus.cleared) {
          _searchController.clear();
          FocusScope.of(context).unfocus();
        }
      },
      builder: (context, state) {
        final uiTextField = UITextField.search(
          controller: _searchController,
          contentPadding: UISpacing.md.edgeInsetsAll(),
          onChanged: searchStreet,
          onSubmitted: searchStreet,
          prefix: _PrefixIcon(
            status: state.status,
          ),
          suffix: _searchController.text.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    context.read<SearchBloc>().add(
                          const SearchCleared(),
                        );
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
        );
        return uiTextField;
      },
    ).paddingOnly(
      right: UISpacing.md,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
}

class _PrefixIcon extends StatelessWidget {
  const _PrefixIcon({required this.status});
  final SearchStatus status;
  @override
  Widget build(BuildContext context) {
    return switch (status) {
      SearchStatus.initial => const Icon(
          Icons.search,
          color: UIColors.grey,
        ).paddingSymmetric(h: UISpacing.md),
      SearchStatus.loaading =>
        const CupertinoActivityIndicator().paddingSymmetric(h: UISpacing.md),
      SearchStatus.success => const Icon(
          Icons.search,
          color: UIColors.grey,
        ).paddingSymmetric(h: UISpacing.md),
      SearchStatus.failure => const Icon(
          Icons.wrong_location_outlined,
          color: UIColors.red,
        ).paddingSymmetric(h: UISpacing.md),
      SearchStatus.cleared => const Icon(
          Icons.search,
          color: UIColors.grey,
        ).paddingSymmetric(h: UISpacing.md),
    };
  }
}
