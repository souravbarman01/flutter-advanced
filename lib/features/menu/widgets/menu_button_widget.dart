import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/dimensions.dart';
import '../domain/models/menu_model.dart';

class MenuButtonWidget extends StatelessWidget {
  final MenuModel menu;
  const MenuButtonWidget({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    final double size = (MediaQuery.of(context).size.width / 4) - Dimensions.paddingSizeDefault;
    final double titleFontSize = MediaQuery.of(context).size.width >= 1300 ? 14 : 12;

    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        if (menu.route.isNotEmpty) {
          context.go(menu.route);
        }
      },
      child: Column(
        children: [
          Container(
            height: size - (size * 0.2),
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
              color: Colors.green,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Image.asset(
              menu.icon,
              width: size,
              height: size,
              color: Theme.of(context).cardColor,
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            menu.title,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ) ??
                TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
