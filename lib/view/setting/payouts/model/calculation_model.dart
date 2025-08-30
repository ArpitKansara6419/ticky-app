class CalculationModel {
  final String timeWorked;
  final String roundedTime;
  final double hourlyRate;
  final double halfDayRate;
  final double fullDayRate;
  final double overtimeRate;
  final String calculationBreakdown;
  final double totalCost;

  CalculationModel({
    required this.timeWorked,
    required this.roundedTime,
    required this.hourlyRate,
    required this.halfDayRate,
    required this.fullDayRate,
    required this.overtimeRate,
    required this.calculationBreakdown,
    required this.totalCost,
  });
}

List<CalculationModel> exampleCases = [
  CalculationModel(
    timeWorked: "2:14",
    roundedTime: "2:00",
    hourlyRate: 10,
    halfDayRate: 20,
    fullDayRate: 30,
    overtimeRate: 50,
    calculationBreakdown: "Hourly rate: 2 × \$10 = \$20",
    totalCost: 20.0,
  ),
  CalculationModel(
    timeWorked: "3:26",
    roundedTime: "3:30",
    hourlyRate: 10,
    halfDayRate: 20,
    fullDayRate: 30,
    overtimeRate: 50,
    calculationBreakdown: "Half-day (\$20) + Extra 30 min (\$5) = \$25",
    totalCost: 25.0,
  ),
  CalculationModel(
    timeWorked: "4:17",
    roundedTime: "4:30",
    hourlyRate: 10,
    halfDayRate: 20,
    fullDayRate: 30,
    overtimeRate: 50,
    calculationBreakdown: "Half-day (\$20) + Extra 30 min (\$5) = \$25",
    totalCost: 25.0,
  ),
  CalculationModel(
    timeWorked: "5:30",
    roundedTime: "5:30",
    hourlyRate: 10,
    halfDayRate: 20,
    fullDayRate: 30,
    overtimeRate: 50,
    calculationBreakdown: "Half-day (\$20) + 1 hr (\$10) + Extra 30 min (\$5) = \$35",
    totalCost: 35.0,
  ),
  CalculationModel(
    timeWorked: "6:45",
    roundedTime: "7:00",
    hourlyRate: 10,
    halfDayRate: 20,
    fullDayRate: 30,
    overtimeRate: 50,
    calculationBreakdown: "Full-day rate = \$30",
    totalCost: 30.0,
  ),
  CalculationModel(
    timeWorked: "8:17",
    roundedTime: "8:30",
    hourlyRate: 10,
    halfDayRate: 20,
    fullDayRate: 30,
    overtimeRate: 50,
    calculationBreakdown: "Full-day rate = \$30 (No overtime since < 8:15)",
    totalCost: 30.0,
  ),
  CalculationModel(
    timeWorked: "8:37",
    roundedTime: "9:00",
    hourlyRate: 10,
    halfDayRate: 20,
    fullDayRate: 30,
    overtimeRate: 50,
    calculationBreakdown: "Full-day (\$30) + Overtime 1 hr (\$50) = \$80",
    totalCost: 80.0,
  ),
  CalculationModel(
    timeWorked: "9:35",
    roundedTime: "10:00",
    hourlyRate: 10,
    halfDayRate: 20,
    fullDayRate: 30,
    overtimeRate: 50,
    calculationBreakdown: "Full-day (\$30) + Overtime 2 hrs (\$100) = \$130",
    totalCost: 130.0,
  ),
];
