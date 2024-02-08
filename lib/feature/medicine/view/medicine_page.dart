import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_pharmacy_admin/feature/add_pages/add_product_page/view/add_product_page.dart';
import 'package:ip_pharmacy_admin/feature/authentication/view/widgets/welcome_widget.dart';
import 'package:ip_pharmacy_admin/feature/medicine/view/widgets/category_item.dart';

import '../../add_pages/add_category_dialog/view/add_category.dart';
import '../../add_pages/add_offer_dialog/view/add_offer.dart';
import '../../categories_page/view/widgets/carousel_item.dart';
import '../../categories_page/view/widgets/home_page_search.dart';
import '../../categories_page/view/widgets/product_item.dart';
import '../../product_details/view/products_details.dart';
import '../manager/medicine_cubit.dart';

class MedicinePage extends StatelessWidget {
  const MedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicineCubit()
        ..getAllCategories()
        ..getAllOffers()
        ..getAllProducts(),
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
                          child: state is GetAllCategoriesLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: cubit.categories
                                        .map((e) => CategoryItem(
                                              categoryModel: e,
                                              productsModel: cubit.products,
                                              offers: cubit.offers,
                                            ))
                                        .toList(),
                                  ),
                                ),
                        ),
                        MaterialButton(
                          shape: const CircleBorder(side: BorderSide(color: Colors.blue)),
                          onPressed: () {
                            showDialog(context: context, builder: (context) => const AddCategory());
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: state is GetAllOffersLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : cubit.offers.isNotEmpty
                            ? Row(
                                children: [
                                  Expanded(
                                    child: CarouselSlider(
                                      items: cubit.offers
                                          .map(
                                            (e) => CarouselItem(image: e.image ?? ''),
                                          )
                                          .toList(),
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        enableInfiniteScroll: false,
                                        reverse: true,
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    shape: const CircleBorder(side: BorderSide(color: Colors.blue)),
                                    onPressed: () {
                                      showDialog(context: context, builder: (context) => const AddOffer());
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                  ),
                  SliverAppBar(
                    collapsedHeight: 80,
                    floating: true,
                    flexibleSpace: Row(
                      children: [
                        Expanded(
                          child: SearchWidget(
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
                        MaterialButton(
                          shape: const CircleBorder(side: BorderSide(color: Colors.blue)),
                          onPressed: () {
                            showDialog(context: context, builder: (context) => const AddProduct());
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverGrid.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: (state is IsSearchingInMedicineInCategory
                            ? cubit.searchMedicineProducts
                            : cubit.products)
                        .map((e) => ProductItem(
                              product: e,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => ProductsDetails(
                                        productsModel: e,
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
