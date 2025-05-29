import 'package:dinero/models/dinero_model.dart';
import 'package:dinero/screens/dinero_detalle_screen.dart';
import 'package:dinero/services/dinero_service.dart';
import 'package:flutter/material.dart';

class DineroScreen extends StatefulWidget {
  const DineroScreen({super.key});

  @override
  State<DineroScreen> createState() => _DineroScreenState();
}

class _DineroScreenState extends State<DineroScreen> {
  final DineroService dineroService = DineroService();
  List<DineroModel> dineros = [];

  Future<void> _getDinero() async {
    dineros = await dineroService.getDinero();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getDinero();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: dineros.length,
        itemBuilder: (context, index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DineroDetalleScreen(
                              dinero: dineros[index],
                            )));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: dineros[index].id ?? '',
                    child: Image.network(dineros[index].imagenFondoUrl ?? ''),
                  ),
                  SizedBox(height: 10),
                  Text(dineros[index].descripcion ?? ''),
                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
