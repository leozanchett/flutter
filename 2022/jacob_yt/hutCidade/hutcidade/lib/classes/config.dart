enum SelectedRequest {
  bus,
  trash,
}

class Config {
  String labelhorarios;
  SelectedRequest selectedRequest;
  String cidadeSelecionada;
  String bairroSelecionado;

  static List<String> cidadesDisponiveis() {
    List<String> _cidades = ['Joaçaba', 'Herval D" Oeste'];
    _cidades.sort();
    return _cidades;
  }

  static final Map<String, List<String>> _bairros = {
    cidadesDisponiveis()[cidadesDisponiveis().indexOf('Joaçaba')]: ['Cordazzo', 'Vila Pedrine', 'Centro', 'João Paulo II ASDADA ASDASD'],
    cidadesDisponiveis()[cidadesDisponiveis().indexOf('Herval D" Oeste')]: ['Rupp', 'Viradouro', 'Centro']
  };

  static List<String> bairrosDisponiveis(String? cidade) {
    List<String> bairrosPorCidade = _bairros[cidade] ?? [];
    bairrosPorCidade.sort();
    return bairrosPorCidade;
  }

  Config()
      : labelhorarios = 'ônibus',
        selectedRequest = SelectedRequest.bus,
        cidadeSelecionada = cidadesDisponiveis().first,
        bairroSelecionado = 'Centro';
}
