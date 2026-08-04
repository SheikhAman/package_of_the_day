import 'package:flutter/material.dart';

import 'models/address.dart';
import 'models/person_model.dart';

const _accent = Color(0xFF6C5CE7);

class Day67JsonAnnotation extends StatefulWidget {
  const Day67JsonAnnotation({super.key});

  @override
  State<Day67JsonAnnotation> createState() => _Day67JsonAnnotationState();
}

class _Day67JsonAnnotationState extends State<Day67JsonAnnotation> {
  late PersonModel person;

  String jsonResult = '';
  String objectResult = '';

  @override
  void initState() {
    super.initState();

    person = PersonModel(
      name: 'Md Siam',
      creditCardNumber: '1234-5678-9999',
      birthday: DateTime(2000, 1, 15),
      address: Address(city: 'Dhaka', street: 'Mirpur', number: 10),
    );
  }

  void convertToJson() {
    final json = person.toJson();

    final newPerson = PersonModel.fromJson(json);

    setState(() {
      jsonResult = json.toString();

      objectResult = newPerson.toString();
    });
  }

  void reset() {
    setState(() {
      jsonResult = '';

      objectResult = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 67 - JSON Annotation',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),

                    blurRadius: 12,

                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                children: [
                  const Text(
                    'Dart Object → JSON → Dart Object',

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    jsonResult.isEmpty
                        ? 'JSON Result will appear here'
                        : jsonResult,

                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    objectResult.isEmpty
                        ? 'Object Result will appear here'
                        : objectResult,

                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: _accent,

                  minimumSize: const Size(double.infinity, 50),
                ),

                icon: const Icon(Icons.sync),

                label: const Text('Convert JSON'),

                onPressed: convertToJson,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                icon: const Icon(Icons.refresh),

                label: const Text('Reset'),

                onPressed: reset,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
