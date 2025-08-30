import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/utils/colors.dart';
import 'package:ticky/utils/functions.dart';
import 'package:ticky/utils/images.dart';
import 'package:ticky/utils/widgets/app_loader.dart';

class MasterDataDropdownWidget extends StatelessWidget {
  final Future<MasterDataResponse>? future;
  final MasterDataResponse? initialData;
  final MasterData? initialValue;
  final bool isSearch;
  final String? searchName;
  final ValueChanged<MasterData?>? onChanged;

  const MasterDataDropdownWidget({
    Key? key,
    required this.future,
    this.initialData,
    this.initialValue,
    required this.onChanged,
    this.isSearch = false,
    this.searchName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MasterDataResponse>(
      initialData: initialData,
      future: future,
      builder: (context, snap) {
        if (snap.hasError) {
          // Handle errors gracefully
          return Text(
            'Failed to load data. Please try again.',
            style: TextStyle(color: Colors.red),
          );
        } else if (snap.hasData) {
          // Ensure data is not null and contains valid values
          var masterDataList = snap.data?.masterDataList.validate() ?? [];
          if (masterDataList.isEmpty) {
            return Text(
              'No options available.',
              style: secondaryTextStyle(),
            );
          }

          // Validate the initialValue against the loaded data
          MasterData? selectedValue;
          if (initialValue != null) {
            selectedValue = masterDataList.firstWhereOrNull((e) => e.value.validate() == initialValue!.value.validate());
          }

          if (isSearch) {
            return DropdownSearch<MasterData>(
              items: (filter, infiniteScrollProps) => masterDataList,
              itemAsString: (MasterData? item) => item?.label ?? "",
              selectedItem: selectedValue,
              compareFn: (MasterData? a, MasterData? b) => a?.value == b?.value,
              decoratorProps: DropDownDecoratorProps(
                decoration: inputDecoration(hint: "Choose"),
              ),
              onChanged: onChanged,
              popupProps: PopupProps.dialog(
                showSearchBox: true,
                cacheItems: true,
                itemBuilder: (context, item, isDisabled, isSelected) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                    child: Text(item.label.validate(), style: primaryTextStyle(size: 14, color: Colors.black)),
                  );
                },
                searchFieldProps: TextFieldProps(
                  decoration: inputDecoration(hint: "Search"),
                  autocorrect: true,
                ),
                dialogProps: DialogProps(
                  shape: RoundedRectangleBorder(
                    borderRadius: radius(),
                  ),
                ),

                // constraints: BoxConstraints(
                //   minWidth: MediaQuery.of(context).size.width * 0.8,
                //   minHeight: MediaQuery.of(context).size.height * 0.6,
                //   maxWidth: MediaQuery.of(context).size.width * 0.9,
                //   maxHeight: MediaQuery.of(context).size.height * 0.8,
                // ),
                title: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    searchName ?? "Select Data",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              enabled: true,
            );
          } else {
            log('isSearch else');
            return DropdownButtonFormField<MasterData>(
              value: selectedValue,
              hint: Text("Choose", style: secondaryTextStyle()),
              validator: (e) {
                if (e == null) return errorThisFieldRequired;
                return null;
              },
              isExpanded: true,
              decoration: inputDecoration(
                svgImage: AppSvgIcons.icIndustryExperience,
                svgIconColor: Colors.black,
              ),
              items: masterDataList.map((data) {
                return DropdownMenuItem(
                  value: data,
                  child: Text(data.label.validate(), style: primaryTextStyle(size: 14)),
                );
              }).toList(),
              onChanged: onChanged,
            );
          }
        } else {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 1),
              borderRadius: radius(),
            ),
            child: Row(
              children: [
                Text(
                  'Fetching Data... ',
                  style: secondaryTextStyle(),
                ).expand(),
                aimLoader(context, size: 24),
              ],
            ),
          );
        }
      },
    );
  }
}

extension IterableExtensions<E> on Iterable<E> {
  /// Returns the first element matching the given [test], or `null` if no element satisfies the condition.
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
