import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/field_record.dart';
import '../../field_capture_providers.dart';
import '../widgets/field_record_form.dart';

class FieldCapturePage extends ConsumerStatefulWidget {
  const FieldCapturePage({super.key});

  @override
  ConsumerState<FieldCapturePage> createState() => _FieldCapturePageState();
}

class _FieldCapturePageState extends ConsumerState<FieldCapturePage> {
  void _saveRecord(FieldRecordFormResult form) {
    final saveUseCase = ref.read(saveFieldRecordUseCaseProvider);

    final record = FieldRecord(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      farmerName: form.farmerName,
      cropType: form.cropType,
      acreageHectares: form.acreageHectares,
      plantDensityIndex: form.plantDensityIndex,
      recordedAt: DateTime.now(),
    );

    saveUseCase(record);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(fieldCaptureRepositoryProvider);
    final records = repository.getPendingRecords();
    final dateFormat = DateFormat('y-MM-dd HH:mm');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Offline Field Capture',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        const Text(
          'Capture farm-level metrics for sync and forecasting.',
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FieldRecordForm(onSubmit: _saveRecord),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Pending records (${records.length})',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        if (records.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('No records yet.'),
            ),
          )
        else
          ...records.map(
            (record) => Card(
              child: ListTile(
                title: Text('${record.farmerName} • ${record.cropType}'),
                subtitle: Text(
                  'Acreage: ${record.acreageHectares.toStringAsFixed(2)} ha\n'
                  'Density: ${record.plantDensityIndex.toStringAsFixed(2)}\n'
                  'Recorded: ${dateFormat.format(record.recordedAt)}',
                ),
                isThreeLine: true,
              ),
            ),
          ),
      ],
    );
  }
}
