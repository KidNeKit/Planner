import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/searcher/searcher_bloc.dart';
import '../../global_components/custom_search.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0).copyWith(top: 0),
          child: CustomSearch(onChangedFunc: (value) {
            context
                .read<SearcherBloc>()
                .add(SearchByNameRequested(request: value));
          }),
        ),
      ),
    );
  }
}
