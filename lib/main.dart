import 'package:flutter/material.dart';
import 'pantallas/genero.dart';
import 'pantallas/persona.dart';
import 'pantallas/universidades.dart';
import 'pantallas/pokemon.dart';
import 'pantallas/wordpress.dart';
import 'pantallas/acerca_de.dart';
import 'pantallas/climas.dart';

void main() => runApp(const CajaApp());

class CajaApp extends StatelessWidget {
  const CajaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caja de herramientas',
      theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
      home: const Inicio(),
    );
  }
}

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  void _ir(BuildContext context, Widget pantalla) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => pantalla));
  }

  @override
  Widget build(BuildContext context) {
    final opciones = <(String, IconData, Widget)>[
      ('Género', Icons.wc, const GeneroPantalla()),
      ('Persona', Icons.person, const Persona()),
      ('Universidades', Icons.school, const Universidades()),
      ('Clima RD', Icons.wb_sunny, const Climas()),
      ('Pokémon', Icons.catching_pokemon, const Pokemon()),
      ('Noticias', Icons.article, const Wordpress()),
      ('Acerca de', Icons.info, const AcercaDe()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Caja de herramientas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset('assets/caja.png', height: 160),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final o in opciones)
                  ListTile(
                    leading: Icon(o.$2),
                    title: Text(o.$1),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _ir(context, o.$3),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}