import 'package:flutter/material.dart';

class FieldRecordFormResult {
  const FieldRecordFormResult({
    required this.farmerName,
    required this.cropType,
    required this.acreageHectares,
    required this.plantDensityIndex,
  });

  final String farmerName;
  final String cropType;
  final double acreageHectares;
  final double plantDensityIndex;
}

class FieldRecordForm extends StatefulWidget {
  const FieldRecordForm({
    required this.onSubmit,
    super.key,
  });

  final ValueChanged<FieldRecordFormResult> onSubmit;

  @override
  State<FieldRecordForm> createState() => _FieldRecordFormState();
}

class _FieldRecordFormState extends State<FieldRecordForm> {
  final _formKey = GlobalKey<FormState>();
  final _farmerNameController = TextEditingController();
  final _cropTypeController = TextEditingController();
  final _acreageController = TextEditingController();
  final _densityController = TextEditingController();

  @override
  void dispose() {
    _farmerNameController.dispose();
    _cropTypeController.dispose();
    _acreageController.dispose();
    _densityController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSubmit(
      FieldRecordFormResult(
        farmerName: _farmerNameController.text.trim(),
        cropType: _cropTypeController.text.trim(),
        acreageHectares: double.parse(_acreageController.text.trim()),
        plantDensityIndex: double.parse(_densityController.text.trim()),
      ),
    );

    _formKey.currentState!.reset();
    _farmerNameController.clear();
    _cropTypeController.clear();
    _acreageController.clear();
    _densityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _farmerNameController,
            decoration: const InputDecoration(labelText: 'Farmer name'),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Enter farmer name'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _cropTypeController,
            decoration: const InputDecoration(labelText: 'Crop type'),
            validator: (value) =>
                (value == null || value.trim().isEmpty) ? 'Enter crop type' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _acreageController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Acreage (ha)'),
            validator: (value) {
              final parsed = double.tryParse(value ?? '');
              return (parsed == null || parsed <= 0) ? 'Enter valid acreage' : null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _densityController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Plant density index'),
            validator: (value) {
              final parsed = double.tryParse(value ?? '');
              return (parsed == null || parsed <= 0) ? 'Enter valid density' : null;
            },
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _submit,
            child: const Text('Save offline record'),
          ),
        ],
      ),
    );
  }
}
