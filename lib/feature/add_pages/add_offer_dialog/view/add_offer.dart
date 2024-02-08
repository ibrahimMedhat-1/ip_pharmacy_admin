import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/commone_widgets/drop_down_menu_item.dart';
import '../manager/add_offer_cubit.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({super.key});

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> with SingleTickerProviderStateMixin {
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
      create: (context) => AddOfferCubit()..getAllCategories(),
      child: BlocConsumer<AddOfferCubit, AddOfferState>(
        listener: (context, state) {},
        builder: (context, state) {
          final AddOfferCubit cubit = AddOfferCubit.get(context);
          return AnimatedScale(
            duration: const Duration(milliseconds: 270),
            scale: animation.value,
            child: state is AddOffersLoading
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
                            cubit.getOfferImage();
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
                              DropdownButton(
                                isExpanded: true,
                                value: cubit.dropDownMenuItemValue,
                                items: cubit.categories
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => dropDownItem(context, e.value.title!),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  cubit.changeDropDownItem(category: value);
                                },
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
                          await cubit.addOffer().then((value) {
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
