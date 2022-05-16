import 'package:flutter/material.dart';

class RecipieStepList extends StatelessWidget {
  final List<String> steps;

  const RecipieStepList({Key? key, required this.steps}) : super(key: key);

  List<Widget> constructList() {
    List<Widget> outputList = [];
    for (int i = 0; i < steps.length; i++) {
      outputList.add(RecipieStepListItem(step: steps[i], id: i + 1));
    }
    return outputList;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: constructList(),
      ),
    );
  }
}

class RecipieStepListItem extends StatelessWidget {
  final String step;
  final int id;

  const RecipieStepListItem({Key? key, required this.step, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Text(
                'Step ' + id.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
              child: Text(
                step,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    overflow: TextOverflow.fade),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
