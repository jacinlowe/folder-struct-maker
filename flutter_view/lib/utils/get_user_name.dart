import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'dart:io' show Platform;

// This is the max win32 username length. It is missing from the win32 package,
// so we'll just create our own constant.
const unLen = 256;

String getUsernameWindows() {
  return using<String>((arena) {
    final buffer = arena.allocate<Utf16>(sizeOf<Uint16>() * (unLen + 1));
    final bufferSize = arena.allocate<Uint32>(sizeOf<Uint32>());
    bufferSize.value = unLen + 1;
    final result = GetUserName(buffer, bufferSize);
    if (result == 0) {
      GetLastError();
      throw Exception(
          'Failed to get win32 username: error 0x${result.toRadixString(16)}');
    }
    return buffer.toDartString();
  });
}

String getHostName() {
  return Platform.localHostname;
}
