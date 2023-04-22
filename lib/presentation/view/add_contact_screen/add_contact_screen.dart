import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency_injection.dart';
import '../../blocs/searcher/searcher_bloc.dart';
import '../global_components/custom_text_sizes.dart';
import 'components/search_header.dart';
import 'components/search_results.dart';

class AddContactScreen extends StatelessWidget {
  static const String routeName = '/addContact';
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const CustomTitleSmallText(text: 'Add Contact'),
      ),
      body: Column(
        children: const [
          SearchHeader(),
          SearchResults(),
        ],
      ),
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => locator.get<SearcherBloc>(),
        child: const AddContactScreen(),
      ),
    );
  }
}
