import 'package:flutter/material.dart';
import '../../app/app_theme.dart';
import '../../app/route_config.dart';
import '../../infrastructure/infrastructure.dart';
import '../_common/_common.dart';
import 'widgets/product_description.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    itemCount = widget.model.orderCounter;
  }

  String get totalPrice => (widget.model.price * itemCount).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BackgroundView.triple(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.borderColor,
            ),
          ),
          actions: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:\$$totalPrice",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppButton(
                label: "Add to cart",
                onTap: () {
                  ShopProvider.of(context).addToCart(p: widget.model, counter: itemCount);
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList.list(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 12,
                      child: Image.network(
                        widget.model.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const ImageErrorView(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ItemCounter(
                        initialValue: itemCount,
                        onChanged: (v) {
                          itemCount = v;
                          setState(() {});
                        },
                      ),
                    ),
                    ProductDescription(model: widget.model),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
