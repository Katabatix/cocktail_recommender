import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef void StringCallback(String tag);

class RecommenderQuestionnaireMain extends StatefulWidget {
  const RecommenderQuestionnaireMain({Key? key}) : super(key: key);
  static const routeName = '/recommender';

  @override
  State<RecommenderQuestionnaireMain> createState() =>
      _RecommenderQuestionnaireMainState();
}

class _RecommenderQuestionnaireMainState
    extends State<RecommenderQuestionnaireMain> {
  List<String> tags = [];
  int _qNumber = Random().nextInt(8);
  List<int> usedQs = [];
  static const maxQNumber = 3;

  @override
  Widget build(BuildContext context) {
    usedQs.add(_qNumber);
    if(usedQs.length > maxQNumber) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/recommender/tinder', arguments: tags);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommend Me A Drink", style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          if(usedQs.length <= maxQNumber)
            _Question(
              _qNumber,
              callback: (tag) {
                setState(() {
                  tags.add(tag);
                  int temp = _qNumber;
                  while(usedQs.contains(temp)){
                    temp = Random().nextInt(8);
                  }
                  _qNumber = temp;
                });
              },
            ),
        ],
      ),
    );
  }
}

class QuestionPrompt {
  String prompt;
  List<String> responses;
  List<String> tags;

  QuestionPrompt(this.prompt, this.responses, this.tags);
}

class _Question extends StatelessWidget {
  // const _Question1({Key? key}) : super(key: key);
  final int _qNum;
  final StringCallback callback;

  const _Question(this._qNum, {required this.callback});

  static List<QuestionPrompt> questionPrompts = [
    QuestionPrompt("How was your day1", [
      "Great",
      "Could have been better",
      "Let's see after a few drinks",
      "Stressed out",
    ], [
      "tag1",
      "tag2",
      "tag3",
      "tag4",
    ]),
    QuestionPrompt("How are you feeling?2", [
      "Looking for a good time!",
      "Overwhelming giddiness",
      "Feeling a little quieter",
      "Stressed out",
    ], [
      "tag1",
      "tag2",
      "tag3",
      "tag4",
    ]),
    QuestionPrompt("How are you feeling?3", [
      "Looking for a good time!",
      "Overwhelming giddiness",
      "Feeling a little quieter",
      "Stressed out",
    ], [
      "tag1",
      "tag2",
      "tag3",
      "tag4",
    ]),
    QuestionPrompt("How are you feeling?4", [
      "Looking for a good time!",
      "Overwhelming giddiness",
      "Feeling a little quieter",
      "Stressed out",
    ], [
      "tag1",
      "tag2",
      "tag3",
      "tag4",
    ]),
    QuestionPrompt("How are you feeling?5", [
      "Looking for a good time!",
      "Overwhelming giddiness",
      "Feeling a little quieter",
      "Stressed out",
    ], [
      "tag1",
      "tag2",
      "tag3",
      "tag4",
    ]),
    QuestionPrompt("How are you feeling?6", [
      "Looking for a good time!",
      "Overwhelming giddiness",
      "Feeling a little quieter",
      "Stressed out",
    ], [
      "tag1",
      "tag2",
      "tag3",
      "tag4",
    ]),
    QuestionPrompt("How are you feeling?7", [
      "Looking for a good time!",
      "Overwhelming giddiness",
      "Feeling a little quieter",
      "Stressed out",
    ], [
      "tag1",
      "tag2",
      "tag3",
      "tag4",
    ]),
    QuestionPrompt("How are you feeling?8", [
      "Looking for a good time!",
      "Overwhelming giddiness",
      "Feeling a little quieter",
      "Stressed out",
    ], [
      "tag1",
      "tag2",
      "tag3",
      "tag4",
    ]),
  ];

  Widget makeButton(int buttonNum) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: (OutlinedButton(
          onPressed: () => callback(questionPrompts[_qNum].tags[buttonNum]),
          child: Text(
            questionPrompts[_qNum].responses[buttonNum],
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(10),
            ),
          ),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Column(
              children: [
                Text(questionPrompts[_qNum].prompt,
                    style: const TextStyle(
                      fontSize: 30,
                    )),
                const SizedBox(height: 30),
                Row(
                  children: [
                    makeButton(0),
                    makeButton(1),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Row(
                  children: [
                    makeButton(2),
                    makeButton(3),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            const SizedBox(height: 150),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}
