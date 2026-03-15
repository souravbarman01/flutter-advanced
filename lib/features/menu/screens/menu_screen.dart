import 'package:flutter/material.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../domain/models/menu_model.dart';
import '../widgets/menu_button_widget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const MenuScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<MenuModel> menuList = <MenuModel>[
      MenuModel(icon: Images.profileIcon, title: 'Profile', route: ''),
      MenuModel(icon: Images.orders, title: 'Orders', route: ''),
      MenuModel(icon: Images.walletIcon, title: 'Wallet', route: ''),
      MenuModel(icon: Images.storeIcon, title: 'Store', route: ''),
      MenuModel(icon: Images.addressIcon, title: 'Address', route: ''),
      MenuModel(icon: Images.couponIcon, title: 'Coupons', route: ''),
      MenuModel(icon: Images.languageIcon, title: 'Language', route: ''),
      MenuModel(icon: Images.chatIcon, title: 'Support', route: ''),
      MenuModel(icon: Images.settings, title: 'Settings', route: ''),
      MenuModel(icon: Images.privacyIcon, title: 'Privacy', route: ''),
      MenuModel(icon: Images.termsIcon, title: 'Terms', route: ''),
      MenuModel(icon: Images.logOut, title: 'Logout', route: ''),
    ];

    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Dimensions.radiusExtraLarge),
        ),
        color: Theme.of(context).cardColor,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.82,
                crossAxisSpacing: Dimensions.paddingSizeExtraSmall,
                mainAxisSpacing: Dimensions.paddingSizeExtraSmall,
              ),
              itemCount: menuList.length,
              itemBuilder: (context, index) => MenuButtonWidget(menu: menuList[index]),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
          ],
        ),
      ),
    );
  }
}
