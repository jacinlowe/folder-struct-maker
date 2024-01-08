import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'attributeProvider.dart';

class FolderNamePreview extends ConsumerStatefulWidget {
  const FolderNamePreview({super.key});

  @override
  ConsumerState<FolderNamePreview> createState() => _FolderNamePreviewState();
}

class _FolderNamePreviewState extends ConsumerState<FolderNamePreview> {
  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.ellipsis,
      ref.watch(attributeCombinerProvider).isEmpty
          ? 'My Project_Hugo Boss_21_Commercial_11-23-32'
          : ref.watch(attributeCombinerProvider),
      style: TextStyle(fontSize: 16),
    );
  }
}
