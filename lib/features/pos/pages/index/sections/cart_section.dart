part of '../page.dart';

class _CartSection extends StatelessWidget {
  const _CartSection({required this.price, required this.qtyItem});

  final int qtyItem;
  final num price;

  @override
  Widget build(BuildContext context) {
    final white = context.theme.scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, POSOrderPage.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(Dimens.dp16),
        padding: const EdgeInsets.all(Dimens.dp12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.dp8),
          color: context.theme.primaryColor,
        ),
        child: Row(
          children: [
            Icon(AppIcons.shoppingCart, color: white),
            Dimens.dp16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RegularText.semiBold(
                    '$qtyItem Item',
                    style: TextStyle(color: white),
                  ),
                  RegularText.semiBold(
                    price.toIDR(),
                    style: TextStyle(fontSize: Dimens.dp12, color: white),
                  ),
                ],
              ),
            ),
            Dimens.dp16.width,
            Icon(Icons.arrow_forward_rounded, color: white),
          ],
        ),
      ),
    );
  }
}
