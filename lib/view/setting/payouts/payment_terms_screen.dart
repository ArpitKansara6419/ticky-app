import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/colors.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';

class PaymentTermsScreen extends StatelessWidget {
  const PaymentTermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Payment Terms"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*  _buildSectionTitle('Engineer Fixed Rates'),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: radius()),
                  width: context.width() / 2 - 24,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Hourly Rate").fit(),
                      Spacer(),
                      Text("\$10"),
                    ],
                  ),
                ),
              ],
            ),
            UL(
              children: [
                Text('Hourly Rate: \$10', style: primaryTextStyle()),
                Text('Half Day Rate: \$20', style: primaryTextStyle()),
                Text('Full Day Rate: \$30', style: primaryTextStyle()),
                Text('Overtime Rate: \$50', style: primaryTextStyle()),
                Text('Out Of Office Hours: \$40', style: primaryTextStyle()),
                Text('Weekend Work: \$60', style: primaryTextStyle()),
                Text('Holiday Work: \$70', style: primaryTextStyle()),
              ],
            ),
            30.height,*/
            _buildSectionTitle('Time Rounding Rules'),
            UL(
              children: [
                Text('0 to 14 minutes → Round down to the last hour', style: primaryTextStyle()),
                Text('15 to 35 minutes → Round to the next half-hour', style: primaryTextStyle()),
                Text('36+ minutes → Round to the next full hour', style: primaryTextStyle()),
              ],
            ),
            20.height,
            _buildSectionTitle('Payment Categories'),
            _buildCategory(
              'Hourly Rate (0 - 2:59 hours)',
              'Total cost = Total Hours × Hourly Rate',
              'Example: 2:14 → Rounded to 2:00, Cost = 2 × \$10 = \$20',
            ),
            _buildCategory(
              'Half-Hour Charge',
              'For each additional hour, an extra half-hour charge is applied.',
              'Example: 3:26 → Rounded to 3:30, Cost = \$25',
            ),
            _buildCategory(
              'Half-Day Rate + Extra (3:00 - 5:59 hours)',
              'Half-day rate applies. If more than 4:30 hours, extra charges apply.',
              'Example: 5:30 → Cost = \$20 + \$10 + \$5 = \$35',
            ),
            _buildCategory(
              'Full-Day Rate (6:00 - 8:14 hours)',
              'Full-day rate applies.',
              'Example: 7:45 → Rounded to 8:00, Cost = \$30',
            ),
            _buildCategory(
              'Overtime (After 8:15 hours)',
              'Full-day rate + Overtime per extra hour.',
              'Example: 8:37 → Rounded to 9:00, Cost = \$30 + 1 × \$50 = \$80',
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Summary Table'),
            _buildSummaryTable(),
          ],
        ),
      ),
    );
  }
}

Widget _buildSummaryTable() {
  return Table(
    border: TableBorder.all(color: Colors.black),
    columnWidths: {
      0: FractionColumnWidth(0.3),
      1: FractionColumnWidth(0.3),
      2: FractionColumnWidth(0.4),
    },
    children: [
      _buildTableRow(['Worked Time', 'Rounded Time', 'Total Cost'], isHeader: true),
      _buildTableRow(['2:14', '2:00', '\$20']),
      _buildTableRow(['3:26', '3:30', '\$25']),
      _buildTableRow(['5:30', '5:30', '\$35']),
      _buildTableRow(['6:45', '7:00', '\$30']),
      _buildTableRow(['8:17', '8:30', '\$30']),
      _buildTableRow(['8:37', '9:00', '\$80']),
      _buildTableRow(['9:35', '10:00', '\$130']),
    ],
  );
}

TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
  return TableRow(
    decoration: BoxDecoration(color: isHeader ? primaryColor : Colors.white),
    children: cells.map((cell) {
      return Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          cell,
          style: TextStyle(
            fontSize: 14,
            color: isHeader ? Colors.white : null,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }).toList(),
  );
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
    ),
  );
}

Widget _buildCategory(String title, String description, String example) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(description, style: TextStyle(fontSize: 14, color: Colors.black87)),
        SizedBox(height: 4),
        Text(' $example', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: primaryColor)),
      ],
    ),
  );
}
