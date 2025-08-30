import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/engineer/technical_skill/technical_skill_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/technical_skill/technical_skills_response.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';
import 'package:ticky/view/engineer/technical_skill/add_technical_skill_screen.dart';
import 'package:ticky/view/engineer/technical_skill/widgets/technical_skill_widget.dart';

class TechnicalSkillScreen extends StatefulWidget {
  const TechnicalSkillScreen({Key? key}) : super(key: key);

  @override
  State<TechnicalSkillScreen> createState() => _TechnicalSkillScreenState();
}

class _TechnicalSkillScreenState extends State<TechnicalSkillScreen> {
  Future<TechnicalSkillResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool? isUpdate}) async {
    future = TechnicalSkillController.getTechnicalSkillListApi();

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
      appBar: commonAppBarWidget("Technical Skills"),
      body: Observer(
        builder: (context) {
          return FutureBuilder<TechnicalSkillResponse>(
            initialData: technicalSkillStore.cachedTechnicalSkillResponse,
            future: future,
            builder: (context, snap) {
              if (snap.hasData) {
                return AnimatedListView(
                  shrinkWrap: true,
                  emptyWidget: "No data available".noDataWidget,
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
                  itemCount: snap.data!.technicalSkillData!.length,
                  itemBuilder: (context, index) {
                    return TechnicalSkillWidget(
                      data: snap.data!.technicalSkillData![index],
                      onTap: () async {
                        await AddTechnicalSkillScreen(data: snap.data!.technicalSkillData![index]).launch(context);
                        init();
                      },
                      onDeleteTab: (context) async {
                        await technicalSkillStore.deleteTechnicalSkill(id: snap.data!.technicalSkillData![index].id.validate());
                        init();
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
          await AddTechnicalSkillScreen().launch(context);
          init(isUpdate: true);
        },
        backgroundColor: context.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
