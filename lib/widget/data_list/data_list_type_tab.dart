part of './data_list.dart';

class DataListTypeTab extends StatefulWidget {
  DataListTypeTab({Key key}) : super(key: key);

  @override
  _DataListTypeTabState createState() => _DataListTypeTabState();
}

class _DataListTypeTabState extends State<DataListTypeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("tab view"),
    );
  }

  // 有类似 TabBar 的状态
  // 比如 entityTemplate 为 selectorLinkCard
  // entityType = card
  // Widget _buildType2() {
  //   return NestedScrollView(
  //     headerSliverBuilder: (context, innerBoxIsScrolled) {
  //       return [
  //         SliverOverlapAbsorber(
  //           handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
  //           sliver: SliverPersistentHeader(
  //             floating: true,
  //             pinned: true,
  //             delegate: _TabBar(child: null),
  //           ),
  //         )
  //       ];
  //     },
  //     body: Builder(
  //       builder: (context) =>
  //           NestedScrollViewViewport(offset: null, handle: null),
  //     ),
  //   );
  // }
}

class _TabBar extends SliverPersistentHeaderDelegate {
  PreferredSize child;
  _TabBar({@required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child?.preferredSize?.height ?? 0;

  @override
  double get minExtent => child?.preferredSize?.height ?? 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
