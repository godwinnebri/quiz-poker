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
          scaffoldBackgroundColor: Color(0xffF8FBFF)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz poker'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              QuestionContainer(
                question:
                    'What is the law that states that for every action, there is an equal and opposite reaction?',
                questionCategory: 'Physics',
                questionNumnber: 1,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() => showSnackBar(context)),
          child: const Icon(Icons.add),
        ));
  }

  void showSnackBar(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Hey there! Thanks for clicking'),
        action: SnackBarAction(
            label: 'Okay', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

class QuestionContainer extends StatelessWidget {
  QuestionContainer(
      {super.key,
      required this.question,
      required this.questionCategory,
      required this.questionNumnber});

  int questionNumnber;
  String questionCategory;
  String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question $questionNumnber',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  questionCategory,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(question),
          ],
        ),
      ),
    );
  }
}
