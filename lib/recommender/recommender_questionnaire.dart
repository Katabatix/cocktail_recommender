import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:cocktail_recommender/utils/theme.dart';

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
  ThemeData theme = getThemeData();

  @override
  Widget build(BuildContext context) {
    usedQs.add(_qNumber);
    if (usedQs.length > maxQNumber) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/recommender/tinder',
            arguments: tags);
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Recommend Me A Drink",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          color: theme.colorScheme.background,
          child: Column(
            children: [
              if (usedQs.length <= maxQNumber)
                _Question(
                  _qNumber,
                  callback: (tag) {
                    setState(() {
                      tags.add(tag);
                      int temp = _qNumber;
                      while (usedQs.contains(temp)) {
                        temp = Random().nextInt(8);
                      }
                      _qNumber = temp;
                    });
                  },
                ),
            ],
          ),
        ));
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
  _Question(this._qNum, {required this.callback});
  ThemeData theme = getThemeData();

  static List<QuestionPrompt> questionPrompts = [
    QuestionPrompt("How was your day", [
      "Great",
      "Could have been better",
      "Let's see after a few drinks",
      "Tiring",
    ], [
      "happy",
      "sad",
      "excited",
      "calm",
    ]),
    QuestionPrompt("Are you a party person?", [
      "YES!",
      "Not really",
      "Sometimes",
      "Too busy to party",
    ], [
      "excited",
      "calm",
      "casual",
      "formal",
    ]),
    QuestionPrompt("Do you pray often?", [
      "Everyday",
      "Sometimes",
      "What's that got to do with cocktails?",
      "None of your business",
    ], [
      "oldschool",
      "casual",
      "modern",
      "sad",
    ]),
    QuestionPrompt("What are your plans for tonight?", [
      "Partying",
      "Dinner at a restaurant",
      "Watch some Netflix",
      "Work",
    ], [
      "excited",
      "casual",
      "calm",
      "sad",
    ]),
    QuestionPrompt("Do you like our Cocktail Recommender App?", [
      "YES!",
      "It's nice",
      "Could have been better",
      "Let's see after a few drinks",
    ], [
      "excited",
      "casual",
      "sad",
      "modern",
    ]),
    QuestionPrompt("What do you prefer to wear to work?", [
      "Formal Suits or Dresses",
      "Semi Formal",
      "Shorts and Hoodies",
      "Whatever the work requires",
    ], [
      "formal",
      "modern",
      "casual",
      "oldschool",
    ]),
    QuestionPrompt("Which of these do you like doing the most?", [
      "Adventure Sports",
      "Gym and Sports",
      "Yoga",
      "No time for leisure",
    ], [
      "excited",
      "modern",
      "calm",
      "sad",
    ]),
    QuestionPrompt("Which is your favourite social media?", [
      "Instagram",
      "Facebook",
      "LinkedIn",
      "TikTok",
    ], [
      "modern",
      "oldschool",
      "formal",
      "happy",
    ]),
  ];

  Widget makeButton(int buttonNum, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: (OutlinedButton(
          onPressed: () => callback(questionPrompts[_qNum].tags[buttonNum]),
          child: Text(
            questionPrompts[_qNum].responses[buttonNum],
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(10),
            ),
            backgroundColor:
                MaterialStateProperty.all(theme.colorScheme.primary),
          ),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.white; //theme.colorScheme.onBackground;
    return Container(
        color: theme.colorScheme.background,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    Text(
                      questionPrompts[_qNum].prompt,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        makeButton(0, textColor),
                        makeButton(1, textColor),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    Row(
                      children: [
                        makeButton(2, textColor),
                        makeButton(3, textColor),
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
        ));
  }
}
