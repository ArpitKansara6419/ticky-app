import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/education/education_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/education/education_response.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';
import 'package:ticky/view/engineer/education/add_education_details.dart';
import 'package:ticky/view/engineer/education/widgets/education_widget.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  Future<EducationResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = EducationController.getEducationListApi();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Education", textSize: 16, textColor: Colors.white),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await AddEducationDetails().launch(context);
          init();
        },
        backgroundColor: context.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Observer(
        builder: (context) {
          return FutureBuilder<EducationResponse>(
            initialData: educationStore.cachedEducationResponse,
            future: future,
            builder: (context, snap) {
              if (snap.hasData) {
                return AnimatedListView(
                  shrinkWrap: true,
                  emptyWidget: "No data available".noDataWidget,
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
                  itemCount: snap.data!.educationData!.length,
                  itemBuilder: (context, index) {
                    return EducationWidget(
                      data: snap.data!.educationData![index],
                      onTap: () async {
                        await AddEducationDetails(data: snap.data!.educationData![index]).launch(context);
                        init();
                      },
                      onDeleteTab: (context) async {
                        await educationStore.deleteEducation(id: snap.data!.educationData![index].id.validate()).then((value) {
                          init();
                        });
                      },
                    );
                  },
                );
              }

              return snapWidgetHelper(snap, loadingWidget: aimLoader(context).center());
            },
          );
        },
      ),
    );
  }
}
