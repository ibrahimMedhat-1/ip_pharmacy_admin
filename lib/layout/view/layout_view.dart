import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_pharmacy_admin/layout/manager/layout_cubit.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          final LayoutCubit cubit = LayoutCubit.get(context);
          return Scaffold(
            body: cubit.pages[cubit.page],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.page,
                onTap: (index) {
                  cubit.changePage(index);
                },
                items: const [
                  BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_outlined)),
                  BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
                ]),
          );
        },
      ),
    );
  }
}
