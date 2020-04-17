part of './items.dart';

class MCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Function onTap;
  final Function onLongPress;
  const MCard({
    Key key,
    this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = Container(
      margin: margin ?? const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
    return container;
  }
}
