import 'package:flutter/material.dart';

class TraceabilityPage extends StatelessWidget {
  const TraceabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text(
          'Traceability',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8),
        Text(
          'Batch provenance and compliance ledger workflows start here.',
        ),
        SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Icon(Icons.verified_outlined),
            title: Text('Compliance-ready ledger pipeline'),
            subtitle: Text(
              'Prepare verifiable farm-to-batch evidence for export workflows.',
            ),
          ),
        ),
      ],
    );
  }
}
