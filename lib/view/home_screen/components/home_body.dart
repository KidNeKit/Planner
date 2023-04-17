import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../models/custom_user.dart';
import '../../../resources/colors.dart';
import 'today_achievements.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              CustomUser user = state.user!;
              return Text(
                  'Hello, ${user.name.isEmpty ? user.username : user.name}',
                  style: Theme.of(context).textTheme.titleMedium);
            },
          ),
          Text(
            'Thursday, 30 Mar 2023',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: neonGreen),
          ),
          const SizedBox(height: 30.0),
          const TodayAchievements(),
          const SizedBox(height: 50.0),
          //const HomeCards(),
        ],
      ),
    );
  }
}
