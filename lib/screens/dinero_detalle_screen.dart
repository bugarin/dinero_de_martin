import 'package:dinero/models/dinero_model.dart';
import 'package:dinero/services/openai_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class DineroDetalleScreen extends StatefulWidget {
  final DineroModel dinero;
  const DineroDetalleScreen({super.key, required this.dinero});

  @override
  State<DineroDetalleScreen> createState() => _DineroDetalleScreenState();
}

class _DineroDetalleScreenState extends State<DineroDetalleScreen> {
  String? historia;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getHistoria();
  }

  void _getHistoria() async {
    setState(() {
      isLoading = true;
    });
    historia = await OpenAIService()
        .getHistoriaDinero(widget.dinero.imagenFondoUrl ?? '');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Hero(
              tag: widget.dinero.id ?? '',
              child: Image.network(widget.dinero.imagenFondoUrlHD ?? ''),
            ),
            SizedBox(height: 10),
            Text(widget.dinero.titulo ?? ''),
            SizedBox(height: 10),
            Text(widget.dinero.descripcion ?? ''),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Volver')),
            SizedBox(height: 10),
            (isLoading)
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MarkdownBody(data: historia ?? ''),
                  )
          ],
        ),
      ),
    );
  }
}
