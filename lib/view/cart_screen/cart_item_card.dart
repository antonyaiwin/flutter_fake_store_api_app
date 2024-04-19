import 'package:flutter/material.dart';
import 'package:flutter_fake_store_api/controller/cart_controller.dart';
import 'package:flutter_fake_store_api/global_widgets/custom_loading_indicator.dart';
import 'package:flutter_fake_store_api/view/home_screen/widgets/add_to_cart_button.dart';
import 'package:provider/provider.dart';

import '../../../model/product_model.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                item.image,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CustomLoadingIndicator(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15,
                            ),
                            Text(item.rating.rate.toString()),
                          ],
                        ),
                        Text(
                          '\$${item.price}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
