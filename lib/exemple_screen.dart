import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela com Estilo')),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/bg_pattern.svg',
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.02)
                    : Colors.black.withOpacity(0.02),
                BlendMode.srcATop,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.local_shipping),
                  title: const Text('Caminhão 1'),
                  subtitle: const Text('Emplacamento: ABC1234'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.local_shipping),
                  title: const Text('Caminhão 2'),
                  subtitle: const Text('Emplacamento: DEF5678'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
