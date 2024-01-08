import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/Features/bored_model.freezed.dart';
part '../generated/Features/bored_model.g.dart';

@freezed
class Activity with _$Activity {
  factory Activity({
    required String key,
    required String activity,
    required String type,
    required int participants,
    required double price,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
