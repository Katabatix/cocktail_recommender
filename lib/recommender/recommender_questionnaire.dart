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
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommend Me A Drink"),
      ),
      body: Column(
        children: [
          _Question(
            _qNumber,
            callback: (tag) {
              setState(() {
                tags.add(tag);
                _qNumber++;
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
  final _qNum;
  final StringCallback callback;

  _Question(this._qNum, {required this.callback});

  static List<QuestionPrompt> questionPrompts = [
    QuestionPrompt(
      "How are you feeling?",
      [
        "Looking for a good time!",
        "Overwhelming giddiness",
        "Feeling a little quieter",
        "Stressed out",
      ],
      [
        "Happy",
        "Excited",
        "Sad",
        "Stressed",
      ]
    ),
    QuestionPrompt(
      "How are you feeling?1",
      [
        "Looking for a good time!",
        "Overwhelming giddiness",
        "Feeling a little quieter",
        "Stressed out",
      ],
      [
        "Happy",
        "Excited",
        "Sad",
        "Stressed",
      ]
    ),
    QuestionPrompt(
      "How are you feeling?2",
      [
        "Looking for a good time!",
        "Overwhelming giddiness",
        "Feeling a little quieter",
        "Stressed out",
      ],
      [
        "Happy",
        "Excited",
        "Sad",
        "Stressed",
      ]
    ),
    QuestionPrompt(
      "How are you feeling?3",
      [
        "Looking for a good time!",
        "Overwhelming giddiness",
        "Feeling a little quieter",
        "Stressed out",
      ],
      [
        "Happy",
        "Excited",
        "Sad",
        "Stressed",
      ]
    ),
  ];

  Widget makeButton(int buttonNum){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: (
            OutlinedButton(
              onPressed: () => callback(questionPrompts[_qNum].tags[buttonNum]),
              child: Text(questionPrompts[_qNum].responses[buttonNum],
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10),
              ),
            ),
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: [
          SizedBox(height: 150),
          Column(
            children: [
              Text(questionPrompts[_qNum].prompt, style: const TextStyle(
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
          SizedBox(height: 150),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}

