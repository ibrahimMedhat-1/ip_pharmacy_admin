import 'package:flutter/material.dart';
import 'package:ip_pharmacy_admin/feature/product_details/view/widgets/top_image.dart';

import '../../../models/product_model.dart';

class ProductsDetails extends StatelessWidget {
  final ProductsModel productsModel;

  const ProductsDetails({super.key, required this.productsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopImageWidget(tag: productsModel.tag!, image: productsModel.image!),
                      Text(
                        productsModel.name!,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              height: 2,
                            ),
                      ),
                      Text(
                        productsModel.description!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Similar Products',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              height: 3,
                            ),
                      ),
                      // state is GetSimilarProductsLoading
                      //     ? const Center(
                      //   child: CircularProgressIndicator(),
                      // )
                      //     :
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        // productsCubit.similarProducts
                        //     .asMap()
                        //     .entries
                        //     .map(
                        //       (e) => ProductItem(
                        //     tag: e.value.tag!,
                        //     productImage: e.value.image!,
                        //     productName: e.value.name!,
                        //     productPrice: e.value.price!,
                        //     productDescription: e.value.description!,
                        //     onTap: () {
                        //       Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (builder) => ProductsDetails(
                        //             tag: e.value.tag!,
                        //             productsModel: e.value,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // )
                        //     .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
