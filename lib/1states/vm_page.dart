import 'package:flutter/material.dart';

class CounterData {
  CounterData(this.count);
  final int count;
}

class CounterModel {
  Future<CounterData> loadCountFromServer() async {
    // final uri = Uri.parse('https://myfluttercounterapp.net/count');
    // final response = await get(uri);
    return CounterData(101);
  }

  Future<CounterData> updateCountOnServer(int newCount) async {
    return CounterData(101);
  }
}

class CounterViewModel extends ChangeNotifier {
  final CounterModel model;
  int? count;
  String? errorMessage;
  CounterViewModel(this.model);

  Future<void> init() async {
    try {
      count = (await model.loadCountFromServer()).count;
    } catch (e) {
      errorMessage = 'Could not initialize counter';
    }
    notifyListeners();
  }

  Future<void> increment() async {
    final currentCount = count;
    if (currentCount == null) {
      throw ('Not initialized');
    }
    try {
      final incrementedCount = currentCount + 1;
      await model.updateCountOnServer(incrementedCount);
      count = incrementedCount;
    } catch (e) {
      errorMessage = 'Could not update count';
    }
    notifyListeners();
  }
}

class VmPage extends StatelessWidget {
  VmPage({super.key});

  final vm = CounterViewModel(CounterModel());

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, child) {
        return Column(
          children: [
            if (vm.errorMessage != null)
              Text(
                'Error: ${vm.errorMessage}',
                style: Theme.of(context).textTheme.labelSmall?.apply(color: Colors.red),
              ),
            Text('Count: ${vm.count}'),
            TextButton(
              onPressed: () {
                vm.increment();
              },
              child: Text('Increment'),
            ),
          ],
        );
      },
    );
  }
}
