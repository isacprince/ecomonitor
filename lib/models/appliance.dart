class Appliance {
  final int? id;
  final String name;
  final double power; // Potência em Watts
  final double hoursPerDay; // Uso diário em horas

  Appliance({
    this.id,
    required this.name,
    required this.power,
    required this.hoursPerDay,
  });

  // Converter Appliance para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'power': power,
      'hoursPerDay': hoursPerDay,
    };
  }

  // Criar Appliance a partir de Map
  factory Appliance.fromMap(Map<String, dynamic> map) {
    return Appliance(
      id: map['id'],
      name: map['name'],
      power: map['power'],
      hoursPerDay: map['hoursPerDay'],
    );
  }
}
