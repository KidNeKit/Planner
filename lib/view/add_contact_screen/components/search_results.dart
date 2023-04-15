import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/searcher/searcher_bloc.dart';
import '../../../models/enum/operation_status.dart';
import '../../global_components/custom_text_sizes.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitleSmallText(
                text: 'Search Results', color: Colors.black),
            const SizedBox(height: 10.0),
            BlocBuilder<SearcherBloc, SearcherState>(
              builder: (context, state) {
                if (state.status == OperationStatus.loading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state.users.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'There are no users satisfying the request',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    itemCount: state.users.length,
                    itemBuilder: (context, index) => const SearchResultItem(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5.0),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 46.0,
        width: 46.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      title:
          const CustomTitleSmallText(text: 'Name Surname', color: Colors.black),
    );
  }
}
