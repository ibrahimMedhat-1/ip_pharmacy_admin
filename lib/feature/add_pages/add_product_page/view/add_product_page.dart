import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_pharmacy_admin/feature/authentication/view/widgets/custom_text_form.dart';

import '../../../../shared/commone_widgets/drop_down_menu_item.dart';
import '../manager/add_product_cubit.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> with SingleTickerProviderStateMixin {
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
      create: (context) => AddProductCubit()..getAllCategories(),
      child: BlocConsumer<AddProductCubit, AddProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          final AddProductCubit cubit = AddProductCubit.get(context);
          return AnimatedScale(
            duration: const Duration(milliseconds: 270),
            scale: animation.value,
            child: state is AddProductLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : AlertDialog(
                    title: const Text('Add a category'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () async {
                              cubit.getProductImage();
                            },
                            child: FittedBox(
                              child: CircleAvatar(
                                maxRadius: 80,
                                foregroundImage: FileImage(File(
                                  cubit.categoryImage == null ? '' : cubit.categoryImage!.path,
                                )),
                              ),
                            ),
                          ),
                          CustomTextForm(
                            controller: cubit.productNameController,
                            obscure: false,
                            labelText: 'Product Name',
                            hintText: 'Product Name',
                            keyboardType: TextInputType.name,
                            validationText: '',
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Category',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                DropdownButton(
                                  isExpanded: true,
                                  value: cubit.dropDownMenuItemValue,
                                  items: cubit.categories
                                      .map(
                                        (e) => dropDownItem(context, e.title!),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    cubit.changeDropDownItem(category: value);
                                  },
                                ),
                              ],
                            ),
                          ),
                          CustomTextForm(
                            controller: cubit.descriptionController,
                            obscure: false,
                            labelText: 'Description',
                            hintText: 'Description',
                            keyboardType: TextInputType.name,
                            validationText: '',
                          ),
                          CustomTextForm(
                            controller: cubit.effectiveMaterialController,
                            obscure: false,
                            labelText: 'Effective Material',
                            hintText: 'Effective Material',
                            keyboardType: TextInputType.name,
                            validationText: '',
                          ),
                          CustomTextForm(
                            controller: cubit.priceController,
                            obscure: false,
                            labelText: 'Price',
                            hintText: 'Price',
                            keyboardType: TextInputType.number,
                            validationText: '',
                          ),
                        ],
                      ),
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
                          await cubit.addProduct().then((value) {
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
