import 'package:intl/intl.dart';

enum SelectedRequest {
  bus,
  trash,
}

enum DiaDaRequisicao {
  semana,
  sabado,
  domingo,
  feriado,
}

class Config {
  String labelhorarios;
  SelectedRequest selectedRequest;
  String cidadeSelecionada;
  String bairroSelecionado;
  String dataRequest;

  static List<String> cidadesDisponiveis() {
    List<String> _cidades = ['Joaçaba', 'Herval D" Oeste'];
    _cidades.sort();
    return _cidades;
  }

  static final Map<String, List<String>> _bairros = {
    cidadesDisponiveis()[cidadesDisponiveis().indexOf('Joaçaba')]: ['Vila Cordazzo', 'Vila Pedrine', 'Centro', 'João Paulo II'],
    cidadesDisponiveis()[cidadesDisponiveis().indexOf('Herval D" Oeste')]: ['Rupp', 'Viradouro', 'Centro', 'Vila Pedrine']
  };

  static List<String> retornaBairrosDaCidade(String? cidade) {
    List<String> bairrosPorCidade = _bairros[cidade] ?? [];
    bairrosPorCidade.sort();
    return bairrosPorCidade;
  }

  Config()
      : labelhorarios = 'ônibus',
        selectedRequest = SelectedRequest.bus,
        cidadeSelecionada = cidadesDisponiveis().first,
        bairroSelecionado = 'Centro',
        dataRequest = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  String toString() {
    return 'selectedRequest: $selectedRequest, cidadeSelecionada: $cidadeSelecionada, bairroSelecionado: $bairroSelecionado, dataRequest: $dataRequest}';
  }
}
