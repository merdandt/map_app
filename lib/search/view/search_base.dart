import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:map_app/search/bloc/search_bloc.dart';

class SearchBase extends StatelessWidget {
  const SearchBase({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final width = MediaQuery.sizeOf(context).width;
        const border = OutlineInputBorder(borderSide: BorderSide.none);
        final maxHeight = MediaQuery.of(context).size.height * .5;
        const minHeight = 60.0;
        final expandedHeigt = maxHeight;
        return Container();
      },
    );
  }
}
