import 'package:flutter/material.dart';
import 'package:range_selector/main.dart';

import 'package:range_selector/randomizer_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RangeSelectorPage extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();

  RangeSelectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              intValueSetter: (value) =>
                  ref.read(randomizerProvider.notifier).setMin(value),
            ),
            const SizedBox(
              height: 30,
            ),
            RangeSelectorTextFormField(
              labelText: "Maximum",
              intValueSetter: (value) =>
                  ref.read(randomizerProvider.notifier).setMax(value),
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
                builder: (context) => const RandomizerPage(),
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
