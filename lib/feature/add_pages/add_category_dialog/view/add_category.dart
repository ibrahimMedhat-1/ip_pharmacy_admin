import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/add_category_cubit.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(microseconds: 270));
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);

    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryCubit()..getAllCategories(),
      child: BlocConsumer<AddCategoryCubit, AddCategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          final AddCategoryCubit cubit = AddCategoryCubit.get(context);
          return AnimatedScale(
            duration: const Duration(milliseconds: 270),
            scale: animation.value,
            child: state is AddCategoryLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : AlertDialog(
                    title: const Text('Add a category'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            cubit.getCategoryImage();
                          },
                          child: FittedBox(
                            child: CircleAvatar(
                              maxRadius: 80,
                              foregroundImage: FileImage(File(
                                cubit.categoryImage == null ? '' : cubit.categoryImage!.path,
                              )),
                            ),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Category',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              TextFormField(
                                controller: cubit.categoryController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    actionsAlignment: MainAxisAlignment.spaceAround,
                    actions: [
                      MaterialButton(
                        textColor: Colors.red,
                        onPressed: () async {
                          await animationController.reverse().then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('Cancel'),
                      ),
                      MaterialButton(
                        textColor: Colors.green,
                        onPressed: () async {
                          await cubit.adCategory().then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
