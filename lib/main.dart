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
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What planet is known as the Red Planet?',
    ),
    Question(
      category: QuestionCategory.art,
      questionText: 'Who painted the famous artwork, the Mona Lisa?',
    ),
    Question(
      category: QuestionCategory.literature,
      questionText: 'Who wrote the play Romeo and Juliet?',
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What is the capital of France?',
    ),
    Question(
      category: QuestionCategory.literature,
      questionText:
          'Who is the main character in the book To Kill a Mockingbird?',
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What is the largest ocean on Earth?',
    ),
    Question(
      category: QuestionCategory.history,
      questionText: 'Who discovered America?',
    ),
    Question(
      category: QuestionCategory.history,
      questionText: 'What is the currency used in Japan?',
    ),
    Question(
      category: QuestionCategory.literature,
      questionText: 'Who composed the opera The Barber of Seville',
    ),
    Question(
      category: QuestionCategory.geography,
      questionText: 'What is the highest mountain in the solar system?',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            questions.add(
              Question(
                category: QuestionCategory.art,
                questionText: 'Enter question text',
              ),
            );
          });
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
    required this.questionNumnber,
  });

  final int questionNumnber;
  final questionCategory;
  final String question;
  // final String image;

  @override
  Widget build(BuildContext context) {
    Question questionn =
        Question(category: questionCategory, questionText: question);
    return Container(
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
                Text(
                  'Question $questionNumnber',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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
  });

  final QuestionCategory category;
  final String questionText;
}
