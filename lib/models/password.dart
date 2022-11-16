class password {
  final int? id;
  final String name;
  final String pass;

  const password({this.id, required this.name, required this.pass});

  factory password.fromJson(Map<String, dynamic> json) =>
      password(id: json['id'], name: json['name'], pass: json['password']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'password': pass};
}
