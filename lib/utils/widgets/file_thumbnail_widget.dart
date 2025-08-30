import 'dart:io';

import 'package:ag_widgets/ag_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pdfx/pdfx.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';

class FileThumbnailWidget extends StatelessWidget {
  final String fileUrl;
  final double size;
  final VoidCallback? onCancel;

  const FileThumbnailWidget({Key? key, required this.fileUrl, this.onCancel, this.size = 100.0}) : super(key: key);

  bool _isPdf(String url) {
    return url.toLowerCase().endsWith('.pdf');
  }

  void _openViewer(BuildContext context) {
    if (_isPdf(fileUrl)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PdfViewerScreen(pdfUrl: fileUrl),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ImageViewerScreen(imageUrl: fileUrl),
        ),
      );
    }
  }

  Future<Image?> _generatePdfThumbnail(String fileUrl) async {
    try {
      // Create a temporary file path for the downloaded PDF.
      final tempDir = Directory.systemTemp.path;
      final tempFilePath = "$tempDir/${DateTimeUtils.convertDateTimeToUTC(
        dateTime: DateTime.now(),
      ).millisecondsSinceEpoch}.pdf";

      // Use the `downloadFile` method to download the PDF file.
      File downloadedFile = await downloadFile(fileUrl, tempFilePath);

      // Open the downloaded PDF and render a thumbnail.
      final document = await PdfDocument.openFile(downloadedFile.path);

      final page = await document.getPage(1);
      final pageImage = await page.render(width: 300, height: 300);
      await page.close();
      // await document.close();

      // Delete the temporary file to save space.
      await downloadedFile.delete();

      // Return the thumbnail as a Flutter Image widget.
      return Image.memory(pageImage!.bytes, fit: BoxFit.cover);
    } catch (e) {
      log('Error generating PDF thumbnail: $e');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () => _openViewer(context),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 0.1),
              color: Colors.white, // Dynamic radius
              boxShadow: defaultBoxShadow(spreadRadius: 3, blurRadius: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size * 0.1), // Clip content to rounded corners
              child: _isPdf(fileUrl)
                  ? FutureBuilder<Image?>(
                      future: _generatePdfThumbnail(fileUrl),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: aimLoader(context, size: 24));
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return Center(child: AppFiles.icPdf.agLoadImage(height: size, width: size));
                        }
                        return snapshot.data!;
                      },
                    )
                  : Image.network(
                      fileUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: aimLoader(context, size: 24));
                      },
                    ),
            ),
          ),
        ),
        // Cancel button
        onCancel != null
            ? Positioned(
                top: -10,
                right: -10,
                child: GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red.shade50),
                    child: const Icon(Icons.close, color: Colors.red, size: 16),
                  ),
                ),
              )
            : Offstage(),
      ],
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;

  const PdfViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: SfPdfViewer.network(widget.pdfUrl),
    );
  }
}

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;

  const ImageViewerScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Viewer')),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
