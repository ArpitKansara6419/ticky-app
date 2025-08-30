import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';

class PdfPreviewView extends StatefulWidget {
  final File file;
  final String fileTitle;
  const PdfPreviewView({super.key, required this.file, required this.fileTitle});

  @override
  State<PdfPreviewView> createState() => _PdfPreviewViewState();
}

class _PdfPreviewViewState extends State<PdfPreviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(widget.fileTitle),
      body: SfPdfViewer.file(
        widget.file,
      ),
    );
  }
}

class PdfPreviewNetworkView extends StatefulWidget {
  final String file;
  final String fileTitle;
  const PdfPreviewNetworkView({super.key, required this.file, required this.fileTitle});

  @override
  State<PdfPreviewNetworkView> createState() => _PdfPreviewNetworkViewState();
}

class _PdfPreviewNetworkViewState extends State<PdfPreviewNetworkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(widget.fileTitle),
      body: SfPdfViewer.network(
        widget.file,
      ),
    );
  }
}
