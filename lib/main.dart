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
      home: const NavScreen(),
    );
  }
}

class NewQuestions {
  final List<Question> questions = [];
}
// ****************************** //
//                                //
//            Nav screen          //
//                                //
// ****************************** //

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
      currentIndex == 1 ? showQuestionModal(context) : null;
    });
  }

  List Pages = [
    HomePage(),
    HomePage(),
  ];

  void showQuestionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddQuestionPage(
          newQuestion: '',
        );
        setState(() {
          currentIndex = 0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: ('Home'),
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8.0, top: 15),
              child: Icon(Icons.home),
            ),
          ),
          BottomNavigationBarItem(
            label: ('Add Question'),
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8.0, top: 15),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
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
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What planet is known as the Red Planet?',
      answer: 'Mars',
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
    ),
    Question(
      category: QuestionCategory.art,
      questionText: 'Who painted the famous artwork, the Mona Lisa?',
      answer: 'Leonardo da Vinci',
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
    ),
    Question(
      category: QuestionCategory.literature,
      questionText: 'Who wrote the play Romeo and Juliet?',
      answer: 'William Shakespeare',
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What is the capital of France?',
      answer: 'Paris',
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
    ),
    Question(
      category: QuestionCategory.literature,
      questionText:
          'Who is the main character in the book To Kill a Mockingbird?',
      answer: 'Atticus Finch',
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What is the largest ocean on Earth?',
      answer: 'The Pacific Ocean',
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
    ),
    Question(
      category: QuestionCategory.history,
      questionText: 'Who discovered America?',
      answer: 'Explorer Christopher Columbus',
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
    ),
    Question(
      category: QuestionCategory.history,
      questionText: 'What is the currency used in Japan?',
      answer: 'Yen',
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
    ),
    Question(
      category: QuestionCategory.literature,
      questionText: 'Who composed the opera The Barber of Seville',
      answer: 'Gioachino Rossini',
      hint1: 'Wrong, try again',
      hint2: 'wrong, you have one more attempt',
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
                const SizedBox.square(dimension: 12),
            itemCount: questions.length,
            itemBuilder: (BuildContext context, int index) {
              return QuestionContainer(
                question: questions[index],
                questionNumber: index + 1,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionDetailScreen(
                        index: index,
                        question: questions[index],
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
                question: questions[randomNumber],
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
    required this.questionNumber,
    required this.onTap,
  });

  final Question question;
  final int questionNumber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
                        'Question ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      //
                      Text(
                        questionNumber.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: questionNumber == null
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
                          question.category.toString(),
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
                          image: NetworkImage(question.category.getImage()),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Flexible(child: Text(question.questionText.toString())),
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
    required this.hint1,
    required this.hint2,
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
    required this.question,
    required this.index,
  }) : super(key: key);

  final int index;
  final Question question;

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  int _attempts = 0;
  String? _selectedAnswer;

  void _checkAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      if (answer == widget.question.answer) {
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
        return widget.question.hint1;
      case 2:
        return widget.question.hint2;
      default:
        return 'The correct answer is ${widget.question.answer}.';
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
                questionNumber: widget.index,
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
                answer: widget.question.answer,
                alphabet: 'A',
                onTap: () => _checkAnswer(widget.question.answer),
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
                      ),
              ),
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

// ****************************** //
//                                //
//       Add Question screen      //
//                                //
// ****************************** //

class AddQuestionPage extends StatelessWidget {
  AddQuestionPage({
    super.key,
    this.newQuestion,
    this.newQuestionAnswer,
  });
  late String? newQuestion;
  late String? newQuestionAnswer;

  @override
  Widget build(BuildContext context) {
    // String newQuestion = '';
    // String newQuestionAnswer = '';

    return Container(
      color: const Color(0xff727375),
      child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),

          //

          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Add Question",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 24),

              //Question textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  height: 54,
                  child: TextFormField(
                    // autofocus: true,
                    //focusNode: _focusNode,
                    //  onTap: _requestFocus,
                    // controller: inputController,
                    onChanged: (newText) {
                      newQuestion = newText;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      label: Text('Task title'),
                      labelStyle: const TextStyle(
                          // color: _focusNode.hasFocus ? primaryColor : grey,
                          fontSize: 16),

                      // prefixIcon: Icon(Icons.email),
                      filled: false,
                      //fillColor: accentColor,
                      hintText: 'Enter Question',
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 18.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              //answer textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  height: 54,
                  child: TextFormField(
                    // autofocus: true,
                    //focusNode: _focusNode,
                    //  onTap: _requestFocus,
                    // controller: inputController,
                    onChanged: (newText) {
                      newQuestionAnswer = newText;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      label: Text('Question answer'),
                      labelStyle: const TextStyle(
                          // color: _focusNode.hasFocus ? primaryColor : grey,
                          fontSize: 16),

                      // prefixIcon: Icon(Icons.email),
                      filled: false,
                      //fillColor: accentColor,
                      hintText: 'Enter task category',
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 18.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // PrimaryButton(
              //   buttonText: "Create task",
              //   onPressed: () {
              //     //do something
              //     addTaskCallback(newTaskTitle);
              //   },
              // )
              InkWell(
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
                        'Add',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
