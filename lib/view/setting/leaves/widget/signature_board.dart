import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:ticky/utils/widgets/save_button_widget.dart';
import 'package:ticky/view/setting/leaves/widget/leave_pdf_component.dart';
import 'dart:ui' as ui;

class SignatureBoard extends StatelessWidget {
  const SignatureBoard({
    super.key,
    required this.title,
    required this.signatureGlobalKey,
    required this.onDrawEnd,
  });

  final String title;
  final GlobalKey<SfSignaturePadState> signatureGlobalKey;
  final void Function(ui.Image image, Uint8List? uInt8List) onDrawEnd;

  @override
  Widget build(BuildContext context) {
    ui.Image? uiImage;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SaveButtonWidget(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: PdfComponents.signaturePad(
              signaturePadKey: signatureGlobalKey,
              height: MediaQuery.sizeOf(context).height,
              onDrawEnd: (image) async {
                uiImage = image;
                final RenderSignaturePad? renderSignaturePad = signatureGlobalKey.currentContext?.findRenderObject() as RenderSignaturePad?;

                Uint8List? localUint8List;
                if (renderSignaturePad != null) {
                  final ui.Image image = await renderSignaturePad.toImage(pixelRatio: 3.0);
                  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                  localUint8List = byteData?.buffer.asUint8List();
                }
                if (uiImage != null) {
                  onDrawEnd(uiImage!, localUint8List);
                }
              },
            ),
          ),
        ],
        onSubmit: () async {
          log('message => $uiImage');
          final RenderSignaturePad? renderSignaturePad = signatureGlobalKey.currentContext?.findRenderObject() as RenderSignaturePad?;

          Uint8List? localUint8List;
          if (renderSignaturePad != null) {
            final ui.Image image = await renderSignaturePad.toImage(pixelRatio: 3.0);
            final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
            localUint8List = byteData?.buffer.asUint8List();
          }
          if (uiImage != null) {
            onDrawEnd(uiImage!, localUint8List);
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
