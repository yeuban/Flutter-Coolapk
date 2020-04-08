import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final List<dynamic> urls;
  final int initIndex;
  const ImageBox({Key key, @required this.urls, this.initIndex = 0})
      : super(key: key);

  static push(final BuildContext context,
      {@required List<dynamic> urls, int initIndex = 0}) {
    Navigator.push(
      context,
      TransparentMaterialPageRoute(
        builder: (_) => ImageBox(
          urls: urls,
          initIndex: initIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _gestureState.currentState.extendedImageGestureState.gestureDetails.totalScale
    return ExtendedImageSlidePage(
      slideType: SlideType.wholePage,
      slideAxis: SlideAxis.both,
      resetPageDuration: Duration(milliseconds: 200),
      child: ExtendedImageGesturePageView.builder(
        controller: PageController(initialPage: initIndex),
        itemCount: urls.length,
        onPageChanged: (value) {},
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return _SubImage(urls[index].toString(), urls.length, index);
        },
      ),
    );
  }
}

class _SubImage extends StatefulWidget {
  final String url;
  final int totalImageCount;
  final int myIndex;
  _SubImage(this.url, this.totalImageCount, this.myIndex, {Key key})
      : super(key: key);

  @override
  __SubImageState createState() => __SubImageState();
}

class __SubImageState extends State<_SubImage> {
  double _scale = 1;

  String get myIndex => (widget.myIndex + 1).toString();
  String get totalImageCount => widget.totalImageCount.toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            // BackButton(),
            Expanded(
              child: Container(
                height: kBottomNavigationBarHeight,
                child: Slider(
                  label: "缩放",
                  max: 3,
                  value: _scale,
                  min: 0.2,
                  onChanged: (value) {
                    context
                        .findRootAncestorStateOfType<
                            ExtendedImageGesturePageViewState>()
                        .extendedImageGestureState
                        ?.handleDoubleTap(scale: value);
                    _scale = value;
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text("$myIndex/$totalImageCount"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        leading: CloseButton(),
        elevation: 1,
        title: Text("蜜汁原因，pc端需要先点击一下图片，才能正常缩放"),
      ),
      body: ExtendedImage.network(
        widget.url,
        width: double.infinity,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        enableSlideOutPage: true,
        mode: ExtendedImageMode.gesture,
        initGestureConfigHandler: (state) {
          return GestureConfig(
            minScale: 0.2,
            maxScale: 3,
            animationMinScale: 0.1,
            animationMaxScale: 3.1,
            speed: 1,
            inertialSpeed: 100,
            initialScale: 1,
            inPageView: true,
            initialAlignment: InitialAlignment.center,
          );
        },
      ),
    );
  }
}
