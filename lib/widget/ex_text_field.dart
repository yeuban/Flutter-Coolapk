// import 'package:extended_text_field/extended_text_field.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

/**
 * 
 * Error: The non-abstract class 'ExtendedEditableTextState' is missing implementations for these members: 
 - TextInputClient.showAutocorrectionPromptRect
 */

// class ExTextField extends StatelessWidget {
//   final TextStyle style;
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final InputDecoration decoration;
//   final TextInputAction textInputAction;
//   final StrutStyle strutStyle;
//   final bool readOnly;
//   final bool autofocus;
//   final bool autocorrect;
//   final bool enableSuggestions;
//   final int maxLines;
//   final int minLines;
//   final bool expands;
//   final int maxLength;
//   final bool maxLengthEnforced;
//   final Function(String value) onChanged;
//   final onEditingComplete;
//   final Function(String value) onSubmitted;
//   final bool enabled;
//   final EdgeInsets scrollPadding;
//   final Function onTap;

//   ExTextField({
//     Key key,
//     this.controller,
//     this.focusNode,
//     this.decoration = const InputDecoration(),
//     this.textInputAction,
//     this.style,
//     this.strutStyle,
//     this.readOnly = false,
//     this.autofocus = false,
//     this.autocorrect = true,
//     this.enableSuggestions = true,
//     this.maxLines = 1,
//     this.minLines,
//     this.expands = false,
//     this.maxLength,
//     this.maxLengthEnforced = true,
//     this.onChanged,
//     this.onEditingComplete,
//     this.onSubmitted,
//     this.enabled,
//     this.scrollPadding = const EdgeInsets.all(20.0),
//     this.onTap,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ExtendedTextField(
//       controller: controller,
//       decoration: decoration,
//       focusNode: focusNode,
//       textInputAction: textInputAction,
//       strutStyle: strutStyle,
//       readOnly: readOnly,
//       autofocus: autofocus,
//       autocorrect: autocorrect,
//       enableSuggestions: enableSuggestions,
//       maxLength: maxLength,
//       maxLengthEnforced: maxLengthEnforced,
//       maxLines: maxLines,
//       minLines: minLines,
//       expands: expands,
//       onChanged: onChanged,
//       onEditingComplete: onEditingComplete,
//       onSubmitted: onSubmitted,
//       onTap: onTap,
//       enabled: enabled,
//       scrollPadding: scrollPadding,
//       specialTextSpanBuilder: ExSpecialTextSpanBuilder(context),
//       style: style,
//     );
//   }
// }

// class ExSpecialTextSpanBuilder extends SpecialTextSpanBuilder {
//   final BuildContext context;
//   ExSpecialTextSpanBuilder(this.context);
//   @override
//   SpecialText createSpecialText(String flag,
//       {TextStyle textStyle, onTap, int index}) {
//     if (flag == null || flag.isEmpty) return null;
//     if (isStart(flag, AtText.flag)) {
//       return AtText(
//         textStyle: textStyle,
//         onTap: onTap,
//         start: index - (AtText.flag.length - 1),
//         context: context,
//       );
//     }
//     return null;
//   }
// }

// class AtText extends SpecialText {
//   static const String flag = "@";
//   final int start;

//   final BuildContext context;
//   AtText({
//     TextStyle textStyle,
//     SpecialTextGestureTapCallback onTap,
//     @required this.context,
//     this.start,
//   }) : super(flag, " ", textStyle);

//   @override
//   InlineSpan finishText() {
//     final textStyle =
//         this.textStyle?.copyWith(color: Theme.of(context).accentColor);

//     final atText = toString();

//     return SpecialTextSpan(
//         text: atText,
//         actualText: atText,
//         start: start,
//         style: textStyle,
//         recognizer: (TapGestureRecognizer()
//           ..onTap = () => onTap?.call(atText)));
//   }
// }
