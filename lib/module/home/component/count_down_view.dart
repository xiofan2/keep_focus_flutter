import 'package:flutter/material.dart';
import 'package:keep_focus/module/prepare_counting/view.dart';

class CountDownView extends StatelessWidget {
  final DraggableScrollableController? controller;
  final double maxChildSize;
  final double minChildSize;

  const CountDownView({
    super.key,
    this.maxChildSize = 0.8,
    this.minChildSize = 0.5,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      snap: true,
      initialChildSize: maxChildSize,
      maxChildSize: maxChildSize,
      minChildSize: minChildSize > maxChildSize ? maxChildSize : minChildSize,
      builder: (BuildContext context, ScrollController controller) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: CustomScrollView(
            controller: controller,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: CountDownSliverPersistentHeaderDelegate(),
              ),
              SliverToBoxAdapter(
                child: PrepareCountingPage(),
              )
            ],
          ),
        );
      },
    );
  }
}

class CountDownSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _dragIndicator(context);
  }

  @override
  double get maxExtent => 30;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

Widget _dragIndicator(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: Container(
      width: 44,
      height: 6,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(100.0),
      ),
    ),
  );
}
