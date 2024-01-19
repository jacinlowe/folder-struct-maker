import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import 'bored_model.dart';

part '../../generated/Features/bored_api/provider.g.dart';

@riverpod
Future<Activity> activity(ActivityRef ref) async {
  final client = http.Client();
  ref.onDispose(client.close);

  final response = await client.get(Uri.https('boredapi.com', '/api/activity'));
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return Activity.fromJson(json);
  // return Future.error(Exception('what happened now'));
}
