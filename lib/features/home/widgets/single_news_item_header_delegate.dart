import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foresight_news_and_articles/core/app_rounded_button.dart';
import 'package:foresight_news_and_articles/core/app_rounded_button_blur.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class SingleNewsItemHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final String category;
  final String imageAssetPath;
  final String date;
  final double topPadding;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;
  final VoidCallback onDelete;

  final Function(double value) borderRadiusAnimationValue;

  @override
  final double maxExtent;
  @override
  final double minExtent;

  const SingleNewsItemHeaderDelegate({
    required this.borderRadiusAnimationValue,
    required this.maxExtent,
    required this.minExtent,
    required this.title,
    required this.category,
    required this.imageAssetPath,
    required this.date,
    required this.topPadding,
    required this.isBookmarked,
    required this.onBookmarkToggle,
    required this.onDelete,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final screenWidth = MediaQuery.of(context).size.width;
    const animationDuration = Duration(milliseconds: 200);

    final showCategoryDate = shrinkOffset < 100;

    final calcForTitleAnimation =
        (maxExtent - shrinkOffset - topPadding - 56 - 100) / 100;

    final titleAnimationValue = calcForTitleAnimation > 1.0
        ? 1.0
        : calcForTitleAnimation < 0.0
            ? 0.0
            : calcForTitleAnimation;

    final calcForTopBarAnimation =
        (maxExtent - shrinkOffset - topPadding - 56) / 50;

    final topBarAnimationValue = calcForTopBarAnimation > 1.0
        ? 1.0
        : calcForTopBarAnimation < 0.0
            ? 0.0
            : calcForTopBarAnimation;

    borderRadiusAnimationValue(topBarAnimationValue);

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          bottom: -10,
          left: 0,
          right: 0,
          child: CachedNetworkImage(
            imageUrl: imageAssetPath,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: SizedBox(
                width: 20.0, // Adjust width for desired size
                height: 20.0, // Adjust height for desired size
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: screenWidth,
            height: maxExtent / 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.black08,
                  AppColors.black06,
                  AppColors.black00
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: AnimatedOpacity(
            opacity: titleAnimationValue,
            duration: animationDuration,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: animationDuration,
                    child: showCategoryDate
                        ? Chip(
                            label: Text(
                              category,
                              style: const TextStyle(color: AppColors.white),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Customize border radius
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1), // Add border
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedContainer(
                    duration: animationDuration,
                    height: showCategoryDate ? 10 : 0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.white,
                              ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: animationDuration,
                    height: showCategoryDate ? 10 : 0,
                  ),
                  AnimatedSwitcher(
                    duration: animationDuration,
                    child: showCategoryDate
                        ? Text(
                            date,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColors.white),
                          )
                        : const SizedBox.shrink(),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: AnimatedContainer(
            duration: animationDuration,
            height: 56 + topPadding,
            width: screenWidth,
            color: AppColors.white.withOpacity(1 - topBarAnimationValue),
            child: Column(
              children: [
                SizedBox(
                  height: topPadding,
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: animationDuration,
                      width: topBarAnimationValue * 10,
                    ),
                    AnimatedCrossFade(
                      duration: animationDuration,
                      crossFadeState: topBarAnimationValue > 0
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      secondChild: AppRoundedButton(
                        iconData: CupertinoIcons.left_chevron,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      firstChild: AppRoundedButtonBlur(
                        iconData: CupertinoIcons.left_chevron,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: AnimatedCrossFade(
                        duration: animationDuration,
                        crossFadeState: topBarAnimationValue > 0
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        secondChild: Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                        firstChild: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppRoundedButtonBlur(
                              iconData: CupertinoIcons.delete_solid,
                              onTap: onDelete,
                            ),
                            AppRoundedButtonBlur(
                              iconData: isBookmarked
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                              onTap: onBookmarkToggle,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            AppRoundedButtonBlur(
                              iconData: Icons.more_horiz,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: animationDuration,
                      width: topBarAnimationValue * 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();
}
