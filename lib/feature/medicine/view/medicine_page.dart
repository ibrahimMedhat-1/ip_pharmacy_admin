import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_pharmacy_admin/feature/add_pages/view/add_category.dart';
import 'package:ip_pharmacy_admin/feature/authentication/view/widgets/welcome_widget.dart';
import 'package:ip_pharmacy_admin/feature/medicine/view/widgets/category_item.dart';
import 'package:ip_pharmacy_admin/models/pharmacy_model.dart';

import '../../categories_page/view/widgets/carousel_item.dart';
import '../../categories_page/view/widgets/home_page_search.dart';
import '../../categories_page/view/widgets/product_item.dart';
import '../../product_details/view/products_details.dart';
import '../manager/medicine_cubit.dart';

class MedicinePage extends StatelessWidget {
  final PharmacyModel pharmacyModel;
  const MedicinePage({required this.pharmacyModel, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicineCubit(),
      child: BlocConsumer<MedicineCubit, MedicineState>(
        listener: (context, state) {},
        builder: (context, state) {
          final MedicineCubit cubit = MedicineCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: WelcomeWidget(welcomeText: 'Intelligent Pharmacy'),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: pharmacyModel.categories!
                                  .map((e) => CategoryItem(
                                        categoryModel: e,
                                        productsModel: pharmacyModel.products!,
                                        offers: pharmacyModel.offers!,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        MaterialButton(
                          shape: const CircleBorder(side: BorderSide(color: Colors.blue)),
                          onPressed: () {
                            showDialog(context: context, builder: (context) => const AddCategory());
                            // Navigator.push(context, NavigateSlideTransition(child: const AddCategory()));
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (pharmacyModel.offers!.isNotEmpty)
                    SliverToBoxAdapter(
                      child: CarouselSlider(
                        items: pharmacyModel.offers!
                            .asMap()
                            .entries
                            .map((e) => CarouselItem(image: e.value.image!))
                            .toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ),
                  SliverAppBar(
                    collapsedHeight: 80,
                    floating: true,
                    flexibleSpace: SearchWidget(
                      controller: cubit.searchController,
                      search: () {
                        cubit.searchMedicine(cubit.searchController.text);
                      },
                      onChange: (value) {
                        if (value.isEmpty) {
                          cubit.isSearching(false);
                        } else {
                          cubit.isSearching(true);
                        }
                      },
                    ),
                  ),
                  SliverGrid.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: (state is IsSearchingInMedicineInCategory
                            ? cubit.searchMedicineProducts
                            : pharmacyModel.products!)
                        .asMap()
                        .entries
                        .map((e) => ProductItem(
                              tag: e.value.tag!,
                              productImage: e.value.image!,
                              productName: e.value.name!,
                              productPrice: e.value.price!,
                              productDescription: e.value.description!,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => ProductsDetails(
                                        tag: e.value.tag!,
                                        productsModel: e.value,
                                      ),
                                    ));
                              },
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
