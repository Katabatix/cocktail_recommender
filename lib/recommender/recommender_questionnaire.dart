import 'package:flutter/material.dart';

typedef void StringCallback(String tag);

class RecommenderQuestionnaireMain extends StatefulWidget {
  const RecommenderQuestionnaireMain({Key? key}) : super(key: key);
  static const routeName = '/recommender';

  @override
  State<RecommenderQuestionnaireMain> createState() => _RecommenderQuestionnaireMainState();
}

class _RecommenderQuestionnaireMainState extends State<RecommenderQuestionnaireMain> {
  List<String> tags = [];
  int _qNumber = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> questions = [
      _Question1(
        callback: (tag) {
          setState(() {
            tags.add(tag);
            _qNumber++;
          });
        },),
      _Question2(callback: (tag) {
        setState(() {
          tags.add(tag);
          _qNumber++;
        });
      },),
      //Add more questions here
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Recommend Me A Drink"),
      ),
      body: Column(
        children: [
          questions[_qNumber],
          TextButton(onPressed: () {
            print(tags);
            print(_qNumber);
          }, child: Text("touch me")),
        ],
      ),
    );
  }
}

class _Question1 extends StatelessWidget {
  // const _Question1({Key? key}) : super(key: key);

  final StringCallback callback;

  _Question1({required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => callback("tag1"),
          child: const Text("Add tag1"),
        ),
        TextButton(
          onPressed: () => callback("tag2"),
          child: const Text("Add tag2"),
        ),
      ],
    );
  }
}

class _Question2 extends StatelessWidget {
  // const _Question1({Key? key}) : super(key: key);

  final StringCallback callback;

  _Question2({required this.callback});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => callback("tag3"),
      child: const Text("Add tag3"),
    );
  }
}


