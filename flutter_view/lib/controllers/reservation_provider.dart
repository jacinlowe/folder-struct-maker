import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationProvider =
    NotifierProvider<ReservationSelector, ReservationType>(
        ReservationSelector.new);

enum ReservationType { week, month }

class ReservationSelector extends Notifier<ReservationType> {
  bool changedState = true;
  @override
  ReservationType build() {
    return ReservationType.week;
  }

  void changeType(ReservationType type) {
    state = type;
    hasChanged();
  }

  bool hasChanged() {
    changedState = !changedState;
    return changedState;
  }
}
