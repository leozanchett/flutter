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

  Config()
      : labelhorarios = 'ônibus',
        selectedRequest = SelectedRequest.bus,
        cidadeSelecionada = '',
        bairroSelecionado = 'Centro',
        dataRequest = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  String toString() {
    return 'selectedRequest: $selectedRequest, cidadeSelecionada: $cidadeSelecionada, bairroSelecionado: $bairroSelecionado, dataRequest: $dataRequest}';
  }
}
