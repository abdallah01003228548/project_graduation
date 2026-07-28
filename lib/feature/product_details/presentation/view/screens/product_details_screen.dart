import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_dimens.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/core/widget/custom_button.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductItemEntity product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int currentIndex = 0;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: AppDimens.spaceS),

            // Product Image Slider
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spaceL,
              ),
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),

                      items: product.images.map((image) {
                        return Image.network(
                          image,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) {
                            return const Icon(
                              Icons.image_not_supported_outlined,
                              size: 50,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  Positioned(
                    right: 15,
                    top: 15,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: AppDimens.spaceS),


            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:List.generate(
                product.images.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? Colors.black
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),


            const SizedBox(height: AppDimens.spaceL),


            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spaceL,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: AppTextStyles.h3Heading.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Text(
                    'EGP ${product.price.toStringAsFixed(0)}',
                    style: AppTextStyles.h3Heading.copyWith(
                      color: AppColors.orangeLight,
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: AppDimens.spaceXL),


            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spaceL,
              ),
              child: Text(
                product.description,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 24,
                  height: 1.6,
                ),
              ),
            ),


            const SizedBox(height: AppDimens.spaceXL),

          ],
        ),
      ),


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: AppDimens.spaceL,
          right: AppDimens.spaceL,
          bottom: 80,
        ),
        child: CustomButton(
          title: 'Add to Cart',
          onPressed: () {},
          backgroundColor: Colors.black,
          height: 58,
          fontSize: 18,
        ),
      ),
    );
  }
}