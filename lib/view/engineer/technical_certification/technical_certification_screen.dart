import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/engineer/technical_certification/technical_certification_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/technical_certification/technical_certification_response.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';
import 'package:ticky/view/engineer/technical_certification/add_technical_certification_screen.dart';
import 'package:ticky/view/engineer/technical_certification/widgets/technical_certification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class TechnicalCertificationScreen extends StatefulWidget {
  const TechnicalCertificationScreen({Key? key}) : super(key: key);

  @override
  State<TechnicalCertificationScreen> createState() => _TechnicalCertificationScreenState();
}

class _TechnicalCertificationScreenState extends State<TechnicalCertificationScreen> {
  Future<TechnicalCertificationResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool? isUpdate}) async {
    future = TechnicalCertificationController.getTechnicalCertificationListApi();

    if (isUpdate.validate()) {
      setState(() {});
    } else {
      MasterDataController.getTechnicalListApi();
      MasterDataController.getTechnicalSkillsLevelListApi();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Technical Certifications"),
      body: Observer(
        builder: (context) {
          return FutureBuilder<TechnicalCertificationResponse>(
            initialData: technicalCertificationStore.cachedTechnicalSkillResponse,
            future: future,
            builder: (context, snap) {
              if (snap.hasData) {
                return AnimatedListView(
                  shrinkWrap: true,
                  emptyWidget: "Result Not Found".noDataWidget,
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
                  itemCount: snap.data!.technicalSkillData!.length,
                  itemBuilder: (context, index) {
                    return TechnicalCertificationWidget(
                      data: snap.data!.technicalSkillData![index],
                      onTap: () async {
                        await AddTechnicalCertificationScreen(data: snap.data!.technicalSkillData![index]).launch(context);
                        init(isUpdate: true);
                      },
                      onDeleteTab: (context) async {
                        await technicalCertificationStore.deleteTechnicalSkill(id: snap.data!.technicalSkillData![index].id.validate()).then((value) {
                          init(isUpdate: true);
                        });
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
          await AddTechnicalCertificationScreen().launch(context);
          init(isUpdate: true);
        },
        backgroundColor: context.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
