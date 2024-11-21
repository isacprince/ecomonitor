class Consumption {
  int? id;
  DateTime date;
  double consumptionKWh; // in kWh
  int applianceId;

  Consumption({
    this.id,
    required this.date,
    required this.consumptionKWh,
    required this.applianceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'consumptionKWh': consumptionKWh,
      'applianceId': applianceId,
    };
  }

  factory Consumption.fromMap(Map<String, dynamic> map) {
    return Consumption(
      id: map['id'],
      date: DateTime.parse(map['date']),
      consumptionKWh: map['consumptionKWh'],
      applianceId: map['applianceId'],
    );
  }
}
