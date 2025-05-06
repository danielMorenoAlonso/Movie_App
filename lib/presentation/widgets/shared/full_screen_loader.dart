import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> loadMessages() {
    final List<String> messages = [
      'Cargando películas',
      'Comprando palomitas de maíz',
      'Cargando populares',
      'Llamando a mi novia',
      'Ya mero...',
      'Esto esta tardando más de lo esperado :(',
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Espere por favor', style: textStyle.titleLarge),
          SizedBox(height: 15),
          CircularProgressIndicator(),
          SizedBox(height: 15),
          StreamBuilder(
            stream: loadMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando');
              return Text(snapshot.data!, style: textStyle.bodyLarge);
            },
          ),
        ],
      ),
    );
  }
}
