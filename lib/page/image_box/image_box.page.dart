import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final List<dynamic> urls;
  const ImageBox({Key key, @required this.urls}) : super(key: key);

  static push(final BuildContext context, {@required List<dynamic> urls}) {
    Navigator.push(
      context,
      TransparentMaterialPageRoute(
        builder: (_) => ImageBox(
          urls: urls,
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
            BackButton(),
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
