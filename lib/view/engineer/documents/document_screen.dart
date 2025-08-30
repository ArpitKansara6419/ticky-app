import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/documents/document_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/documents/document_response.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';
import 'package:ticky/view/engineer/documents/add_document_screen.dart';
import 'package:ticky/view/engineer/documents/widgets/document_widget.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  Future<DocumentResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool isUpdate = false}) async {
    future = DocumentController.getDocumentListApi();

    if (isUpdate.validate()) {
      setState(() {});
    }
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("ID Documents"),
      body: Observer(
        builder: (context) {
          return FutureBuilder<DocumentResponse>(
            initialData: documentStore.documentData,
            future: future,
            builder: (context, snap) {
              if (snap.hasData) {
                return AnimatedListView(
                  shrinkWrap: true,
                  emptyWidget: "No data available".noDataWidget,
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
                  itemCount: snap.data!.documentData!.length,
                  itemBuilder: (context, index) {
                    return DocumentWidget(
                      data: snap.data!.documentData![index],
                      onTap: () async {
                        await AddDocumentScreen(data: snap.data!.documentData![index]).launch(context);
                        init(isUpdate: true);
                      },
                      onDeleteTab: (context) async {
                        await documentStore.deleteDocument(id: snap.data!.documentData![index].id.validate());
                        init(isUpdate: true);
                      },
                    );
                  },
                );
              }

              return snapWidgetHelper(snap,
                  loadingWidget: aimLoader(
                    context,
                  ).center());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await AddDocumentScreen().launch(context);
          init(isUpdate: true);
        },
        backgroundColor: context.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
