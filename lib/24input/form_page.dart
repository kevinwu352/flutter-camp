import 'package:flutter/material.dart';

// Form 包含的子元素是 FormField
// TextFormField / DropdownMenuFormField / DropdownButtonFormField

// required Widget child
// bool? canPop 能否返回上个页面
// PopInvokedWithResultCallback<Object?>? onPopInvokedWithResult
//   如果有未保存信息，返回时提示用户要不要保存之类的，见下面的例子
//   先用 canPop 阻击返回，用户点返回的时候回调到这里并且 didPop=false，然后在这里判断要不要返回，如果要，则从里面调用返回操作
//   如果 canPop=true，也会回调到这里，但 didPop=true，这里也阻击不了了，只相当于一个事后通知
// VoidCallback? onChanged
// AutovalidateMode? autovalidateMode

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<bool?> showAlert() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Ok')),
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Form(
        key: _formKey,
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          print('called: $didPop $result');
          if (didPop) {
            return;
          }
          final res = await showAlert();
          print(res);
          if (res == true && context.mounted) {
            Navigator.of(context).pop();
            // SystemNavigator.pop();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: 'Enter your email'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
