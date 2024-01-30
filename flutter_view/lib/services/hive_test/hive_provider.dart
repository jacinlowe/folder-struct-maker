import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'test_hive_class.dart';

part '../../generated/services/hive_test/hive_provider.g.dart';

@riverpod
class HiveAccount extends _$HiveAccount {
  final Box<List<Account>> box = Hive.box('account');

  List<Account> build() {
    return _loadState();
  }

  void saveAccount() async {
    final newAccount = Account(amount: 100, accountName: 'Tony');
    state.add(newAccount);
    _saveState();
    ref.notifyListeners();
    print(state);
  }

  void deleteAccount() async {
    await box.clear();
    state = _loadState();
    ref.notifyListeners();
    print(state);
  }

  void _saveState() {
    print('saveState');
    box.put('accountList', state);
  }

  List<Account> _loadState() {
    return box.get('accountList') ?? [];
  }
}
