import 'package:flutter/material.dart';

class AcercaDe extends StatelessWidget {
  const AcercaDe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircleAvatar(
                radius: 70, backgroundImage: AssetImage('assets/foto.png')),
            SizedBox(height: 16),
            Text('Ericka Ranocchi',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Desarrolladora de software'),
            SizedBox(height: 20),
            ListTile(
                leading: Icon(Icons.email),
                title: Text('felipeisabela840@gmail.com')),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text('849-623-5627')),
            ListTile(
                leading: Icon(Icons.code),
                title: Text('github.com/felipeisabela84')),
          ],
        ),
      ),
    );
  }
}