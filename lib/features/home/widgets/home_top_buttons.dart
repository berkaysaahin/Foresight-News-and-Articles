import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/app_rounded_button.dart';

class HomeTopButtons extends StatelessWidget {
  const HomeTopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            AppRoundedButton(
              iconData: Icons.menu,
              onTap: () {},
            ),
            const Spacer(),
            AppRoundedButton(
              iconData: Icons.search,
              onTap: () {},
            ),
            const SizedBox(
              width: 10,
            ),
            AppRoundedButton(
              iconData: Icons.notifications_outlined,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
