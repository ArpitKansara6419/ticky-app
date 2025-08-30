import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CommonDataCheckBoxWidget<T> extends StatelessWidget {
  final List<T> dataList;
  final Widget Function(bool isChecked) checkBoxBuilder;
  final bool Function(T item) isSelected;
  final void Function(T item) onItemTap;
  final String Function(T item) labelExtractor;

  const CommonDataCheckBoxWidget({
    Key? key,
    required this.dataList,
    required this.checkBoxBuilder,
    required this.isSelected,
    required this.onItemTap,
    required this.labelExtractor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        dataList.length,
        (index) {
          T data = dataList[index];
          return InkWell(
            onTap: () => onItemTap(data),
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 17,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  checkBoxBuilder(isSelected(data)),
                  8.width,
                  Text(
                    labelExtractor(data),
                    style: primaryTextStyle(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
