import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_dimens.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/core/widget/custom_button.dart';
import 'package:project_graduation/feature/cart/presentation/view_model/cart/cart_cubit.dart';
import 'package:project_graduation/feature/favourite/presentation/view_model/favourite_cubit.dart';
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
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: _cartListener,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _buildBody(),
        bottomNavigationBar: _buildAddToCartButton(),
      ),
    );
  }

  Widget _buildBody() {
    final product = widget.product;

    final List<String> images = product.images
        .where((image) => image.trim().isNotEmpty)
        .toList();

    if (images.isEmpty && product.thumbnail.trim().isNotEmpty) {
      images.add(product.thumbnail);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimens.spaceS),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spaceL,
            ),
            child: _buildImageSection(images),
          ),

          const SizedBox(height: AppDimens.spaceS),

          if (images.length > 1) _buildImageIndicators(images.length),

          const SizedBox(height: AppDimens.spaceL),

          _buildProductHeader(),

          const SizedBox(height: AppDimens.spaceXL),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spaceL,
            ),
            child: Text(
              product.description,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 18,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 130),
        ],
      ),
    );
  }

  Widget _buildImageSection(List<String> images) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: images.isEmpty
              ? const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 60,
                  ),
                )
              : CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  items: images.map((image) {
  debugPrint('PRODUCT IMAGE URL = $image');

  return Image.network(
    image,
    width: double.infinity,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      debugPrint('IMAGE ERROR = $error');

      return const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 60,
        ),
      );
    },
  );
}).toList(),
                ),
        ),

        Positioned(
          right: 15,
          top: 15,
          child: _buildFavouriteButton(),
        ),
      ],
    );
  }

  Widget _buildFavouriteButton() {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        final isFavourite = context
            .read<FavouriteCubit>()
            .isFavourite(widget.product.id);

        return Container(
          decoration: const BoxDecoration(
            color: AppColors.lightGray,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => _toggleFavourite(context),
            icon: Icon(
              isFavourite
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 24,
              color: isFavourite ? AppColors.orangeLight : AppColors.charcoal,
            ),
          ),
        );
      },
    );
  }

  Future<void> _toggleFavourite(BuildContext context) async {
    final result = await context
        .read<FavouriteCubit>()
        .toggleFavourite(widget.product);

    if (!context.mounted || result == null) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            result
                ? 'Added to favourites'
                : 'Removed from favourites',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Widget _buildImageIndicators(int imageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        imageCount,
        (index) {
          final isSelected = _currentImageIndex == index;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 7,
            width: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? AppColors.charcoal
                  : Colors.grey.shade300,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductHeader() {
    final product = widget.product;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.spaceL,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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

          const SizedBox(width: 12),

          Text(
            'USD ${product.price.toStringAsFixed(2)}',
            style: AppTextStyles.h3Heading.copyWith(
              color: AppColors.orangeLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(
        AppDimens.spaceL,
        AppDimens.spaceS,
        AppDimens.spaceL,
        AppDimens.spaceL,
      ),
      child: CustomButton(
        title: 'Add to Cart',
        onPressed: _addToCart,
        backgroundColor: Colors.black,
        height: 58,
        fontSize: 18,
      ),
    );
  }

  void _addToCart() {
    final productId = int.tryParse(widget.product.id);

    if (productId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid product'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    context.read<CartCubit>().addToCart(productId);
  }

  void _cartListener(BuildContext context, CartState state) {
    if (state is CartItemAdded) {
      _showSnackBar(
        context,
        state.message,
      );
    } else if (state is CartItemAddError) {
      _showSnackBar(
        context,
        state.errorMessage,
      );
    }
  }

  void _showSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}