import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/core/common/snackbar/my_snackbar.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Scholarship Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile
            },
          ),
        ],
      ),
      // ),
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: state.views.elementAt(state.selectedIndex),
        );
      }),
      bottomNavigationBar:
          BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school_rounded),
              label: 'University',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Course',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: state.selectedIndex,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey[500],
          onTap: (index) {
            context.read<HomeCubit>().onTabTapped(index);
          },
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        );
      }),
    );
  }
}
