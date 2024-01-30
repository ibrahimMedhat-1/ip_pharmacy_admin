import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_pharmacy_admin/feature/categories_page/view/widgets/carousel_item.dart';
import 'package:ip_pharmacy_admin/feature/categories_page/view/widgets/home_page_search.dart';
import 'package:ip_pharmacy_admin/feature/categories_page/view/widgets/product_item.dart';

import '../../../models/offers_model.dart';
import '../../../models/product_model.dart';
import '../../product_details/view/products_details.dart';
import '../pharmacy_categories_cubit/pharmacy_categories_cubit.dart';

class PharmacyCategoriesPage extends StatelessWidget {
  final String tag;
  final List<ProductsModel> products;
  final List<OffersModel> offers;

  const PharmacyCategoriesPage({super.key, required this.tag, required this.products, required this.offers});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyCategoriesCubit()
        ..filterProducts(products, tag)
        ..filterOffers(offers, tag),
      child: BlocConsumer<PharmacyCategoriesCubit, PharmacyCategoriesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final PharmacyCategoriesCubit cubit = PharmacyCategoriesCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Hero(
                      tag: tag,
                      child: Text(
                        tag,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  if (cubit.offers.isNotEmpty)
                    SliverToBoxAdapter(
                      child: state is FilterAllOffersToCategoryItesOnlyLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CarouselSlider(
                              items: cubit.offers
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => CarouselItem(image: e.value.image!),
                                  )
                                  .toList(),
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                              ),
                            ),
                    ),
                  SliverAppBar(
                    leading: const SizedBox(),
                    pinned: true,
                    expandedHeight: 100,
                    collapsedHeight: 100,
                    surfaceTintColor: Colors.white,
                    flexibleSpace: SearchWidget(
                      controller: cubit.searchController,
                      search: () {
                        cubit.searchMedicineInCategory(cubit.searchController.text);
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
                  if (state is FilterAllProductsToCategoryItesOnlyLoading)
                    const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    SliverGrid.count(
                      crossAxisCount: 2,
                      children: (state is IsSearchingInMedicineInCategory
                              ? cubit.searchCategoryProducts
                              : cubit.categoryProducts)
                          .asMap()
                          .entries
                          .map((e) {
                        return ProductItem(
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
                        );
                      }).toList(),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
