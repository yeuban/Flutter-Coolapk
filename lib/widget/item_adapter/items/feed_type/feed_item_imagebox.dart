part of './feed.item.dart';

// Widget buildImageBox2x3(List<dynamic> picArr) {
//   picArr.removeRange(4, picArr.length);
//   return AspectRatio(
//     aspectRatio: 2 / 3,
//     child: GridView.count(
//       physics: NeverScrollableScrollPhysics(),
//       crossAxisCount: 3,
//       crossAxisSpacing: 4,
//       mainAxisSpacing: 4,
//       shrinkWrap: true,
//       childAspectRatio: 2 / 3,
//       children: picArr.map((pic) {
//         return ExtendedImage.network(
//           pic,
//           cache: true,
//           fit: BoxFit.cover,
//           filterQuality: FilterQuality.low,
//         );
//       }).toList(),
//     ),
//   );
// }

Widget buildImageBox1x2(List<dynamic> picArr) {
  picArr.removeRange(2, picArr.length);
  return GridView.extent(
    physics: NeverScrollableScrollPhysics(),
    maxCrossAxisExtent: 2,
    crossAxisSpacing: 4,
    mainAxisSpacing: 4,
    shrinkWrap: true,
    childAspectRatio: 2,
    children: picArr.map((pic) {
      return ExtendedImage.network(
        pic,
        cache: true,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.low,
      );
    }).toList(),
  );
}

Widget buildImageBox1x3(List<dynamic> picArr) {
  picArr.removeRange(3, picArr.length);
  return PhysicalModel(
    borderRadius: BorderRadius.circular(8),
    clipBehavior: Clip.antiAlias,
    color: Colors.transparent,
    child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      shrinkWrap: true,
      childAspectRatio: .7,
      children: picArr.map((pic) {
        return ExtendedImage.network(
          pic,
          cache: true,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
        );
      }).toList(),
    ),
  );
}

Widget buildIfImageBox(final dynamic source, final BuildContext context) {
  final List<dynamic> picArr = source["picArr"];
  final maxHeight = MediaQuery.of(context).size.height / 2.5;
  Widget picWidget;
  if (picArr != null) {
    switch (picArr.length) {
      case 6:
        picWidget = buildImageBox1x3(picArr);
        break;
      case 2:
        picWidget = buildImageBox1x2(picArr);
        break;
      case 3:
        picWidget = buildImageBox1x3(picArr);
        break;
      case 1:
        if (picArr[0] == "") break;
        picWidget = ExtendedImage.network(
          picArr[0],
          cache: true,
          fit: BoxFit.cover,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
        );
        break;
      default:
        if (picArr.length >= 4) {
          picWidget = buildImageBox1x3(picArr);
        }
    }
  }
  final fmh = (maxHeight < 240 ? 240 : maxHeight > 500 ? 500 : maxHeight);
  return Container(
    constraints: BoxConstraints(maxHeight: fmh.toDouble()),
    padding: const EdgeInsets.all(0).copyWith(top: 8, bottom: 8),
    child: picWidget ?? const SizedBox(),
  );
}
