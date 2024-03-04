import 'package:flutter/material.dart';
import 'package:range_selector/randomizer_page.dart';

class RangeSelectorPage extends StatefulWidget {
  const RangeSelectorPage({super.key});

  @override
  State<RangeSelectorPage> createState() => _RangeSelectorPageState();
}

class _RangeSelectorPageState extends State<RangeSelectorPage> {
  final formKey = GlobalKey<FormState>();
  int _minValue = 0;
  int _maxValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Range'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            RangeSelectorTextFormField(
              labelText: "Minimum",
              intValueSetter: (value) => _minValue = value,
            ),
            const SizedBox(
              height: 30,
            ),
            RangeSelectorTextFormField(
              labelText: "Maximum",
              intValueSetter: (value) => _maxValue = value,
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            if (formKey.currentState?.validate() == true) {
              formKey.currentState?.save();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RandomizerPage(
                  min: _minValue,
                  max: _maxValue,
                ),
              ));
            }
          }),
    );
  }
}

class RangeSelectorTextFormField extends StatelessWidget {
  const RangeSelectorTextFormField(
      {super.key, required this.labelText, required this.intValueSetter});
  final String labelText;
  final void Function(int value) intValueSetter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      keyboardType:
          const TextInputType.numberWithOptions(decimal: false, signed: true),
      onSaved: (newValue) => intValueSetter(int.parse(newValue ?? '')),
      validator: (value) {
        if (value == null || int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
