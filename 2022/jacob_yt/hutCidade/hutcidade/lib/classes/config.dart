import 'package:intl/intl.dart';

enum SelectedRequest {
  bus,
  trash,
}

class Config {
  String labelhorarios;
  SelectedRequest selectedRequest;
  String cidadeSelecionada;
  String bairroSelecionado;
  String dataRequest;
  String labelDataSelecionada;

  Config()
      : labelhorarios = 'ônibus',
        selectedRequest = SelectedRequest.bus,
        cidadeSelecionada = '',
        bairroSelecionado = 'Centro',
        dataRequest = DateFormat('dd-MM-yyyy').format(DateTime.now()),
        labelDataSelecionada = 'semana';

  @override
  String toString() {
    return 'selectedRequest: $selectedRequest, cidadeSelecionada: $cidadeSelecionada, bairroSelecionado: $bairroSelecionado, dataRequest: $dataRequest}';
  }
}
