import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/industry_exp/industry_experience_controller.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/industry_exp/industry_experience_response.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';
import 'package:ticky/view/engineer/industry_exp/add_industry_experience_screen.dart';
import 'package:ticky/view/engineer/industry_exp/widgets/industry_experience_widget.dart';

class IndustryExperienceScreen extends StatefulWidget {
  const IndustryExperienceScreen({Key? key}) : super(key: key);

  @override
  State<IndustryExperienceScreen> createState() => _IndustryExperienceScreenState();
}

class _IndustryExperienceScreenState extends State<IndustryExperienceScreen> {
  Future<IndustryExperienceResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init({bool? isUpdate}) async {
    future = IndustryExperienceController.getIndustryExperienceListApi();

    MasterDataController.getIndustryExpListApi();
    MasterDataController.getIndustryLevelListApi();

    if (isUpdate.validate()) {
      setState(() {});
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Industry Experience"),
      body: Observer(
        builder: (context) {
          return FutureBuilder<IndustryExperienceResponse>(
            initialData: industryExperienceStore.cachedIndustryExperienceResponse,
            future: future,
            builder: (context, snap) {
              if (snap.hasData) {
                return AnimatedListView(
                  shrinkWrap: true,
                  emptyWidget: "No data available".noDataWidget,
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
                  itemCount: snap.data!.industryExperienceData!.length,
                  itemBuilder: (context, index) {
                    return IndustryExperienceWidget(
                      data: snap.data!.industryExperienceData![index],
                      onTap: () async {
                        await AddIndustryExperienceScreen(data: snap.data!.industryExperienceData![index]).launch(context);
                        init();
                      },
                      onDeleteTab: (BuildContext) async {
                        await industryExperienceStore.deleteIndustryExperience(id: snap.data!.industryExperienceData![index].id!.validate()).then((value) {
                          init();
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
          await AddIndustryExperienceScreen().launch(context);
          init();
        },
        backgroundColor: context.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
