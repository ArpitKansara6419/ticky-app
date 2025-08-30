import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/engineer/spoken_languages/spoken_language_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/spoken_languages/spoken_language_response.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';
import 'package:ticky/view/engineer/spoken_languages/add_spoken_languages_screen.dart';
import 'package:ticky/view/engineer/spoken_languages/widgets/spoken_languages_widget.dart';

class SpokenLanguageScreen extends StatefulWidget {
  const SpokenLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SpokenLanguageScreen> createState() => _SpokenLanguageScreenState();
}

class _SpokenLanguageScreenState extends State<SpokenLanguageScreen> {
  Future<SpokenLanguageResponse>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = SpokenLanguageController.getSpokenLanguageListApi();

    MasterDataController.getSpokenLanguagesListApi();
    MasterDataController.getSpokenLanguageLevelListApi();
    MasterDataController.getSpokenLanguageProficiencyListApi();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Spoken Languages"),
      body: Observer(
        builder: (context) {
          return FutureBuilder<SpokenLanguageResponse>(
            initialData: spokenLanguageStore.cachedSpokenLanguageResponse,
            future: future,
            builder: (context, snap) {
              if (snap.hasData) {
                return AnimatedListView(
                  shrinkWrap: true,
                  emptyWidget: "No data available".noDataWidget,
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
                  itemCount: snap.data!.spokenLanguageData!.length,
                  itemBuilder: (context, index) {
                    return SpokenLanguagesWidget(
                      data: snap.data!.spokenLanguageData![index],
                      onTap: () async {
                        await AddSpokenLanguagesScreen(data: snap.data!.spokenLanguageData![index]).launch(context);
                        init();
                      },
                      onDeleteTab: (context) async {
                        await spokenLanguageStore.deleteSpokenLanguage(id: snap.data!.spokenLanguageData![index].id.validate()).then((value) {
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
          await AddSpokenLanguagesScreen().launch(context);
          init();
        },
        backgroundColor: context.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
