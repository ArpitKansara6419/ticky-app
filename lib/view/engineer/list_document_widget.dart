import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/file_thumbnail_widget.dart';

class ListDocumentWidget extends StatelessWidget {
  final List<String>? documents;
  final VoidCallback? onCancel;
  final double? fileSize;
  const ListDocumentWidget({Key? key, required this.documents, this.onCancel, this.fileSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (documents.validate().isNotEmpty) {
      return Wrap(
        direction: Axis.horizontal,
        spacing: 16,
        runSpacing: 8,
        children: List.generate(
          documents!.length,
          (index) {
            String values = Config.imageUrl + documents![index];
            // log("Url: ${values}");
            return FileThumbnailWidget(fileUrl: values, size: fileSize ?? 60, onCancel: onCancel);
          },
        ),
      );
    }
    return Offstage();
  }
}
