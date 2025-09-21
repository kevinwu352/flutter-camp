import 'package:flutter/material.dart';

class SelectableButton extends StatefulWidget {
  const SelectableButton({super.key, required this.selected, this.style, required this.onPressed, required this.child});

  final bool selected;
  final ButtonStyle? style;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  State<SelectableButton> createState() => _SelectableButtonState();
}

class _SelectableButtonState extends State<SelectableButton> {
  late final WidgetStatesController controller;

  @override
  void initState() {
    super.initState();
    // 初始化时，如果是选中的，把 .selected 加到 controller 里面
    print('init selected:${widget.selected}');
    controller = WidgetStatesController(<WidgetState>{if (widget.selected) WidgetState.selected});
  }

  // 按钮点击后，会走到这里，具体触发流程是什么？
  @override
  void didUpdateWidget(SelectableButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('update selected:${widget.selected} state:${controller.value}');

    // widget.selected 是外面传进来的，这个值在 page 里面是一个 state，它在变
    // 但是仅仅把 selected 传进来不够，因为 button 内部的状态不会变
    // 按钮内部的状态，我们要告诉 controller，然后 button 里面就改变了，然后就根据 button 状态来显示相应的样式
    if (widget.selected != oldWidget.selected) {
      controller.update(WidgetState.selected, widget.selected);
    }
    print('update state:${controller.value}');
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      statesController: controller,
      style: widget.style,
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}

class ButtonStatePage extends StatefulWidget {
  const ButtonStatePage({super.key});
  @override
  State<ButtonStatePage> createState() => _ButtonStatePageState();
}

class _ButtonStatePageState extends State<ButtonStatePage> {
  bool selected = false;

  // 这里面只是选中状态的样式，默认样式在默认里
  static const ButtonStyle style = ButtonStyle(
    foregroundColor: WidgetStateProperty<Color?>.fromMap(<WidgetState, Color>{WidgetState.selected: Colors.white}),
    backgroundColor: WidgetStateProperty<Color?>.fromMap(<WidgetState, Color>{WidgetState.selected: Colors.indigo}),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Button State')),
      body: Center(
        child: SelectableButton(
          selected: selected,
          style: style,
          onPressed: () {
            setState(() => selected = !selected);
          },
          child: const Text('toggle selected'),
        ),
      ),
    );
  }
}
