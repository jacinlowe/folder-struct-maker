import 'package:hive_flutter/hive_flutter.dart';

part '../../generated/services/hive_test/test_hive_class.g.dart';

@HiveType(typeId: 1)
class Account {
  @HiveField(1)
  int amount;
  @HiveField(2)
  String accountName;

  Account({required this.amount, required this.accountName});

  @override
  String toString() {
    return 'Account{amount: $amount, accountName: $accountName}';
  }
}
