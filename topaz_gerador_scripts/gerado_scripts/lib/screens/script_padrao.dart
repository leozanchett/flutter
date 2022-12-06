import 'package:flutter/material.dart';

class ScriptPadrao extends StatefulWidget {
  const ScriptPadrao({super.key});

  @override
  State<ScriptPadrao> createState() => _ScriptPadraoState();
}

class _ScriptPadraoState extends State<ScriptPadrao> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _channel = TextEditingController();
  final TextEditingController _taskDescription = TextEditingController();
  final TextEditingController _filename = TextEditingController();
  final TextEditingController _jira = TextEditingController();
  final TextEditingController _azure = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _taskDescription,
                      decoration: const InputDecoration(
                        labelText: 'Descrição da tarefa',
                        hintText: 'Informe a descrição da tarefa',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe a descrição da tarefa';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _channel,
                      decoration: const InputDecoration(
                        labelText: 'Canal',
                        hintText: 'Pix Recebimentos, Pix Pagamentos, C4E',
                        border: OutlineInputBorder(),
                        //constraints: BoxConstraints(maxWidth: 600),
                        prefixIcon: Icon(Icons.people),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o canal';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _filename,
                      decoration: const InputDecoration(
                        labelText: 'Nome do arquivo',
                        hintText: 'servcore-ng-dml_V002C001R932.sql',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o nome do arquivo';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _jira,
                      decoration: const InputDecoration(
                        labelText: 'Jira',
                        hintText: 'Informe o número da Jira',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o número da Jira';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _azure,
                      decoration: const InputDecoration(
                        labelText: 'Azure',
                        hintText: 'Informe o número do Azure',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o número do Azure';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
