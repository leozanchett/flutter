class Horarios {
  String hora;
  String rota;

  Horarios()
      : hora = '',
        rota = '';

  Horarios.fromMap(Map<String, dynamic> map)
      : hora = map['hora'],
        rota = map['rota'];
}
