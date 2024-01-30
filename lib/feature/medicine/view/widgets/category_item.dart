import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/category_model.dart';
import '../../../../models/offers_model.dart';
import '../../../../models/product_model.dart';
import '../../../categories_page/view/pharmacy_categories.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final List<ProductsModel> productsModel;
  final List<OffersModel> offers;

  const CategoryItem({
    super.key,
    required this.categoryModel,
    required this.productsModel,
    required this.offers,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => PharmacyCategoriesPage(
                tag: categoryModel.title!,
                products: productsModel,
                offers: offers,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: categoryModel.picture!,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                imageBuilder: (context, imageProvider) => ImageIcon(CachedNetworkImageProvider(categoryModel.picture!)),
              ),
            ),
            Hero(
              tag: categoryModel.title!,
              child: Text(
                categoryModel.title!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
