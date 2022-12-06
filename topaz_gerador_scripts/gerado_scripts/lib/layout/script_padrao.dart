import 'package:flutter/material.dart';

class ScriptPadrao extends StatefulWidget {
  const ScriptPadrao({super.key});

  @override
  State<ScriptPadrao> createState() => _ScriptPadraoState();
}

class _ScriptPadraoState extends State<ScriptPadrao> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          child: Text('Script Padrão'),
        )
      ],
    );
  }
}
