import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:ag_widgets/widgets/ag_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

class DocumentUploadComponent extends StatefulWidget {
  final int ticketNumber;
  final TicketWorks data;

  const DocumentUploadComponent({Key? key, required this.ticketNumber, required this.data}) : super(key: key);

  @override
  State<DocumentUploadComponent> createState() => _DocumentUploadComponentState();
}

class _DocumentUploadComponentState extends State<DocumentUploadComponent> {
  @override
  void initState() {
    super.initState();

    /// todo review this
    // init();
  }

  void init() async {
    ticketStartWorkStore.setAttachmentFiles(file: await FilePickerFunctions.getMultipleFile());
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleFormComponent(
          text: 'Upload Documents',
          child: Observer(
            builder: (context) {
              return AppTextField(
                textFieldType: TextFieldType.EMAIL_ENHANCED,
                isValidationRequired: false,
                readOnly: true,
                suffix: FilePickerFunctions.FilePickerPopupMenu(
                  icon: Icons.upload,
                  onFileSelection: (file) async {
                    ticketStartWorkStore.setAttachmentFiles(
                      file: await file,
                    );
                  },
                ),
                // IconButton(
                //   onPressed: () async {},
                //   icon: Icon(Icons.upload),
                // ),
                decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Upload Items"),
              );
            },
          ),
        ),
        16.height,
        Observer(
          builder: (context) {
            return Wrap(
              runSpacing: 16,
              spacing: 16,
              children: List.generate(
                ticketStartWorkStore.attachmentFiles.length,
                (index) {
                  var data = ticketStartWorkStore.attachmentFiles[index];
                  if (data.path.contains("http")) {
                    return AgCachedImage(
                      imageUrl: data.path,
                      backgroundColorList: darkBrightColors,
                      width: context.width() / 4 - 16,
                      height: 100,
                      boxFit: BoxFit.cover,
                      isCircle: false,
                    );
                  }
                  return getFileTypeImage(data.path).agLoadImage(height: 70, width: 70);
                  // return Container(
                  //   child: Image.file(data, width: context.width() / 4 - 16, height: 100, fit: BoxFit.cover),
                  // );
                },
              ),
            );
          },
        ),
        32.height,
        Align(
          alignment: Alignment.centerRight,
          child: Observer(
            builder: (context) {
              return ButtonAppLoader(
                isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.ticketsNotesApiState].validate(),
                child: AppButton(
                  onTap: ticketStartWorkStore.attachmentFiles.validate().isNotEmpty ? () async => await ticketStartWorkStore.addDocument(data: widget.data) : null,
                  text: "Upload Selected Items",
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
