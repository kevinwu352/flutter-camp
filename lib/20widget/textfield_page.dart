import 'package:flutter/material.dart';

// Object groupId = EditableText
// TextEditingController? controller
// FocusNode? focusNode
// UndoHistoryController? undoController
// InputDecoration? decoration = const InputDecoration()
// TextInputType? keyboardType
// TextInputAction? textInputAction
// TextCapitalization textCapitalization = TextCapitalization.none
// TextStyle? style
// StrutStyle? strutStyle
// TextAlign textAlign = TextAlign.start
// TextAlignVertical? textAlignVertical
// TextDirection? textDirection
// bool readOnly = false
// @Deprecated('Use `contextMenuBuilder` instead. ' 'This feature was deprecated after v3.3.0-0.5.pre.') ToolbarOptions? toolbarOptions
// bool? showCursor
// bool autofocus = false
// MaterialStatesController? statesController
// String obscuringCharacter = '•'
// bool obscureText = false
// bool? autocorrect
// SmartDashesType? smartDashesType
// SmartQuotesType? smartQuotesType
// bool enableSuggestions = true
// int? maxLines = 1
// int? minLines
// bool expands = false
// int? maxLength
// MaxLengthEnforcement? maxLengthEnforcement
// ValueChanged<String>? onChanged
// VoidCallback? onEditingComplete
// ValueChanged<String>? onSubmitted
// AppPrivateCommandCallback? onAppPrivateCommand
// List<TextInputFormatter>? inputFormatters
// bool? enabled
// bool? ignorePointers
// double cursorWidth = 2.0
// double? cursorHeight
// Radius? cursorRadius
// bool? cursorOpacityAnimates
// Color? cursorColor
// Color? cursorErrorColor
// BoxHeightStyle? selectionHeightStyle
// BoxWidthStyle? selectionWidthStyle
// Brightness? keyboardAppearance
// EdgeInsets scrollPadding = const EdgeInsets.all(20.0)
// DragStartBehavior dragStartBehavior = DragStartBehavior.start
// bool? enableInteractiveSelection
// bool? selectAllOnFocus
// TextSelectionControls? selectionControls
// GestureTapCallback? onTap
// bool onTapAlwaysCalled = false
// TapRegionCallback? onTapOutside
// TapRegionUpCallback? onTapUpOutside
// MouseCursor? mouseCursor
// InputCounterWidgetBuilder? buildCounter
// ScrollController? scrollController
// ScrollPhysics? scrollPhysics
// Iterable<String>? autofillHints = const <String>[]
// ContentInsertionConfiguration? contentInsertionConfiguration
// Clip clipBehavior = Clip.hardEdge
// String? restorationId
// @Deprecated('Use `stylusHandwritingEnabled` instead. ' 'This feature was deprecated after v3.27.0-0.2.pre.') bool scribbleEnabled = true
// bool stylusHandwritingEnabled = EditableText.defaultStylusHandwritingEnabled
// bool enableIMEPersonalizedLearning = true
// EditableTextContextMenuBuilder? contextMenuBuilder = _defaultContextMenuBuilder
// bool canRequestFocus = true
// SpellCheckConfiguration? spellCheckConfiguration
// TextMagnifierConfiguration? magnifierConfiguration
// List<Locale>? hintLocales

class TextfieldPage extends StatelessWidget {
  const TextfieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TextField')),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Text('--'),
    );
  }
}
