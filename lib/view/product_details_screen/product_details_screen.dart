import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_store_api/controller/cart_controller.dart';
import 'package:flutter_fake_store_api/global_widgets/custom_loading_indicator.dart';
import 'package:flutter_fake_store_api/model/product_model.dart';
import 'package:flutter_fake_store_api/view/home_screen/widgets/add_to_cart_button.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: item.image,
                        height: 250,
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error),
                        ),
                        progressIndicatorBuilder: (context, url, progress) =>
                            const CustomLoadingIndicator(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          double rating = item.rating.rate;
                          return Icon(
                            Icons.star,
                            size: 15,
                            color: rating.round() ~/ (index + 1) == 0
                                ? Colors.grey
                                : Colors.amber,
                          );
                        }),
                        const SizedBox(width: 10),
                        Text(
                          item.rating.count.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Ratings',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    Text(
                      'Description',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 20,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.description,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 215, 215, 215),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.price.toStringAsFixed(2),
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
                const Spacer(),
                Consumer<CartController>(
                  builder: (context, value, child) {
                    return AddToCartButton(
                      count: value.getItemCount(item.id),
                      onTap: () {
                        value.addItemToCart(item);
                      },
                      onAddTap: () {
                        value.addItemToCart(item);
                      },
                      onRemoveTap: () {
                        value.removeItemFromCart(item);
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
