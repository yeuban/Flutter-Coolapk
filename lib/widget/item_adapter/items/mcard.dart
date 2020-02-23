part of './items.dart';

class MCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Function onTap;
  final bool enableInk;
  const MCard(
      {Key key,
      this.child,
      this.padding,
      this.margin,
      this.onTap,
      this.enableInk = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = Container(
      margin: margin ?? const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
    if (enableInk)
      return InkWell(
        onTap: onTap ?? () {},
        child: container,
      );
    return container;
  }
}
