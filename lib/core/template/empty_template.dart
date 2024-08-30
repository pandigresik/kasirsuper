import 'package:flutter/material.dart';
import 'package:kasirsuper/core/core.dart';

class EmptyTemplate extends StatelessWidget {
  const EmptyTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(MainAssets.empty, width: Dimens.dp200),
            Dimens.dp32.height,
            const SubtitleText(
              'There are no products here',
              align: TextAlign.center,
            ),
            Dimens.dp16.height,
            const RegularText(
              'You do not have a product in the shop. '
              'Please add products first to start selling.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
