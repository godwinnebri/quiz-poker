import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xffF8FBFF)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Question> questions = [
    Question(
      category: QuestionCategory.physics,
      questionText:
          'What is the law that states that for every action, there is an equal and opposite reaction?',
      answer: 'Newton\'s 3rd law of motion',
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What planet is known as the Red Planet?',
      answer: 'Mars',
    ),
    Question(
      category: QuestionCategory.art,
      questionText: 'Who painted the famous artwork, the Mona Lisa?',
      answer: 'Leonardo da Vinci',
    ),
    Question(
      category: QuestionCategory.literature,
      questionText: 'Who wrote the play Romeo and Juliet?',
      answer: 'William Shakespeare',
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What is the capital of France?',
      answer: 'Paris',
    ),
    Question(
      category: QuestionCategory.literature,
      questionText:
          'Who is the main character in the book To Kill a Mockingbird?',
      answer: 'Atticus Finch',
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What is the largest ocean on Earth?',
      answer: 'The Pacific Ocean',
    ),
    Question(
      category: QuestionCategory.history,
      questionText: 'Who discovered America?',
      answer: 'Explorer Christopher Columbus',
    ),
    Question(
      category: QuestionCategory.history,
      questionText: 'What is the currency used in Japan?',
      answer: 'Yen',
    ),
    Question(
      category: QuestionCategory.literature,
      questionText: 'Who composed the opera The Barber of Seville',
      answer: 'Gioachino Rossini',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomNumber = random.nextInt(9 + 1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0,
        title: const Text('Quiz poker'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: LayoutBuilder(builder: (context, constraints) {
          return ListView.separated(
            padding: const EdgeInsets.all(0),
            scrollDirection:
                constraints.maxWidth > 430 ? Axis.horizontal : Axis.vertical,
            separatorBuilder: (context, index) =>
                const SizedBox(height: 12, width: 12),
            itemCount: questions.length,
            itemBuilder: (BuildContext context, int index) {
              return QuestionContainer(
                question: questions[index].questionText,
                questionCategory: questions[index].category,
                questionNumnber: 1 + index,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionDetailScreen(
                        index: index,
                        question: questions[index].questionText,
                        questionCategory: questions[index].category,
                        correctAnswer: questions[index].answer,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionDetailScreen(
                index: randomNumber,
                question: questions[randomNumber].questionText,
                questionCategory: questions[randomNumber].category,
                correctAnswer: questions[randomNumber].answer,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // void showSnackBar(BuildContext context) {
  //   final scaffold = ScaffoldMessenger.of(context);
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content: const Text('Hey there! Thanks for clicking'),
  //       action: SnackBarAction(
  //           label: 'Okay', onPressed: scaffold.hideCurrentSnackBar),
  //     ),
  //   );
  // }
}

class QuestionContainer extends StatelessWidget {
  const QuestionContainer({
    super.key,
    required this.question,
    required this.questionCategory,
    this.questionNumnber,
    required this.onTap,
  });

  final int? questionNumnber;
  final questionCategory;
  final String question;
  final VoidCallback onTap;
  // final String image;

  @override
  Widget build(BuildContext context) {
    Question questionn = Question(
      category: questionCategory,
      questionText: question,
      answer: question,
    );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 393,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Question',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      //
                      Text(
                        questionNumnber.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: questionNumnber == null
                              ? Colors.white.withOpacity(0)
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          questionCategory.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(fontSize: 13, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(questionn.category.getImage()),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Flexible(child: Text(question)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum QuestionCategory {
  physics,
  geography,
  art,
  literature,
  history;

  @override
  String toString() => toTitleCase(name);
  String getImage() {
    switch (this) {
      case QuestionCategory.art:
        return 'https://guardian.ng/wp-content/uploads/2022/12/African-art-scaled.jpeg';
      case QuestionCategory.geography:
        return 'https://www.redeemer.ca/wp-content/uploads/program-geography-social-share.jpg';
      case QuestionCategory.history:
        return 'https://i.natgeofe.com/k/1bc6572d-cb59-48b4-8d95-3e3a0f3c1b8a/history-og_16x9.jpg?w=1200';
      case QuestionCategory.literature:
        return 'https://nationaltoday.com/wp-content/uploads/2022/06/4-Literature.jpg';
      case QuestionCategory.physics:
        return 'https://assets.ltkcontent.com/images/26593/physics_27c5571306.jpg';
      default:
        return '';
    }
  }
}

String toTitleCase(String name) => name[0].toUpperCase() + name.substring(1);

class Question {
  Question({
    required this.category,
    required this.questionText,
    this.hint1 = 'Wrong, try again',
    this.hint2 = 'Last chance',
    required this.answer,
  });

  final QuestionCategory category;
  final String questionText;
  final String hint1;
  final String hint2;
  final String answer;
}

// ****************************** //
//                                //
//     Question detail screen     //
//                                //
// ****************************** //

class QuestionDetailScreen extends StatefulWidget {
  const QuestionDetailScreen({
    Key? key,
    required this.index,
    required this.question,
    required this.questionCategory,
    required this.correctAnswer,
  }) : super(key: key);

  final int index;
  final String question;
  final QuestionCategory questionCategory;
  final String correctAnswer;

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  int _attempts = 0;
  String? _selectedAnswer;

  void _checkAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      if (answer == widget.correctAnswer) {
        _attempts = 3;

        _showDialog(true);
      } else {
        _attempts++;
        if (_attempts < 3) {
          _showDialog(false);
        } else {
          _showDialog(false);
        }
      }
    });
  }

  void _showDialog(bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? 'Correct!' : 'Incorrect'),
          content: Text(
              isCorrect ? 'You have selected the correct answer.' : _getHint()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _getHint() {
    switch (_attempts) {
      case 1:
        return 'wrong answer';
      case 2:
        return 'wrong answer, last chance';
      default:
        return 'The correct answer is ${widget.correctAnswer}.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0,
        title: Text('Question ${widget.index + 1}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuestionContainer(
                question: widget.question,
                questionCategory: widget.questionCategory,
                questionNumnber: null,
                onTap: () {},
              ),
              const SizedBox(height: 40),
              const Text(
                'Select the corrct answer',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              OptionsContainer(
                answer: widget.correctAnswer,
                alphabet: 'A',
                onTap: () => _checkAnswer(widget.correctAnswer),
                showCheck: _attempts > 2 ? true : false,
              ),
              const SizedBox(height: 20),
              OptionsContainer(
                answer: 'Wrong answer',
                alphabet: 'B',
                onTap: () => _checkAnswer('Wrong answer'),
                showCheck: false,
              ),
              const SizedBox(height: 20),
              OptionsContainer(
                answer: 'Wrong answer',
                alphabet: 'C',
                onTap: () => _checkAnswer('Wrong answer'),
                showCheck: false,
              ),
              const SizedBox(height: 24),

              //
              Container(
                  child: _attempts < 3
                      ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Attempts: ',
                                ),
                                Text(
                                  '$_attempts',
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Center(
                                child: Text(
                                  'Back to questions',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}

//
//
//options widget
class OptionsContainer extends StatelessWidget {
  const OptionsContainer({
    super.key,
    required this.answer,
    required this.alphabet,
    required this.onTap,
    required this.showCheck,
  });

  final String alphabet;
  final String answer;
  final VoidCallback onTap;
  final bool showCheck;
  // final String image;

  @override
  Widget build(BuildContext context) {
    // Question questionn = Question(
    //   category: questionCategory,
    //   questionText: question,
    //   answer: question,
    // );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(60)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(0.1),
                          ),
                          child: Center(
                              child: Text(
                            alphabet,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                        const SizedBox(width: 14),
                        Flexible(child: Text(answer)),
                      ],
                    ),
                  ),
                  Container(
                    child: showCheck
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
