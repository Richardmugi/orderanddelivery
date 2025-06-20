// File: widgets/category_grid.dart

import 'package:flutter/material.dart';
import '../repositories/category_repository.dart';
import '../helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/custom/btn.dart';
import 'package:active_ecommerce_flutter/custom/device_info.dart';
import 'package:active_ecommerce_flutter/custom/useful_elements.dart';
import 'package:active_ecommerce_flutter/data_model/category_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/presenter/bottom_appbar_index.dart';
import 'package:active_ecommerce_flutter/repositories/category_repository.dart';
import 'package:active_ecommerce_flutter/screens/category_list_n_product/category_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/l10n/app_localizations.dart';

import '../../custom/category_item_card_widget.dart';

class CategoryGrid extends StatelessWidget {
  final bool isTopCategory;
  final bool isBaseCategory;
  final String? slug;

  const CategoryGrid({
    Key? key,
    required this.isTopCategory,
    required this.isBaseCategory,
    this.slug,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = isTopCategory
        ? CategoryRepository().getTopCategories()
        : CategoryRepository().getCategories(parent_id: slug);

    return FutureBuilder<CategoryResponse>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SingleChildScrollView(
            child: ShimmerHelper().buildCategoryCardShimmer(
                is_base_category: isBaseCategory),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(height: 10);
        } else if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.7,
              crossAxisCount: 3,
            ),
            itemCount: snapshot.data!.categories!.length,
            padding: EdgeInsets.only(
                left: 18, right: 18, bottom: isBaseCategory ? 30 : 0),
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CategoryItemCardWidget(
                  categoryResponse: snapshot.data!, index: index);
            },
          );
        } else {
          return SingleChildScrollView(
            child: ShimmerHelper().buildCategoryCardShimmer(
              is_base_category: isBaseCategory,
            ),
          );
        }
      },
    );
  }
}
