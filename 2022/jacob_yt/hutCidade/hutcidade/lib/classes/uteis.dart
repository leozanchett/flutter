class Uteis {
  static String formata_caminho_firebase({required String patch}) {
    List<String> caracteres_probidos = ['ç', 'á'];
    List<String> caracteres_permitidos = ['c', 'a'];

    patch = patch.toLowerCase();
    for (int x = 0; x < patch.length; x++) {
      if (caracteres_probidos.contains(patch[x])) {
        patch = patch.replaceAll(patch[x], caracteres_permitidos[caracteres_probidos.indexOf(patch[x])]);
      }
    }
    return patch.replaceAll(RegExp(r'[^\w]'), '');
  }
}
