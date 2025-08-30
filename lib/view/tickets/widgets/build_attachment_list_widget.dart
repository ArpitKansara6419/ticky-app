import 'package:flutter/material.dart';
import 'package:ticky/view/engineer/list_document_widget.dart';

class BuildAttachmentListWidget extends StatelessWidget {
  final List<String> attachmentList;

  const BuildAttachmentListWidget({Key? key, required this.attachmentList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
      child: ListDocumentWidget(documents: attachmentList),
    );
  }
}
