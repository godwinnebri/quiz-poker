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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map> questions = [
    {
      'number': 1,
      'category': 'Physics',
      'image':
          'https://assets.ltkcontent.com/images/26593/physics_27c5571306.jpg',
      'question':
          'What is the law that states that for every action, there is an equal and opposite reaction?',
    },
    {
      'number': 2,
      'category': 'Geography',
      'image':
          'https://www.redeemer.ca/wp-content/uploads/program-geography-social-share.jpg',
      'question': 'What planet is known as the Red Planet?',
    },
    {
      'number': 3,
      'category': 'Art',
      'image':
          'https://guardian.ng/wp-content/uploads/2022/12/African-art-scaled.jpeg',
      'question': 'Who painted the famous artwork, the Mona Lisa?',
    },
    {
      'number': 4,
      'category': 'Literature',
      'image':
          'https://nationaltoday.com/wp-content/uploads/2022/06/4-Literature.jpg',
      'question': 'Who wrote the play Romeo and Juliet?',
    },
    {
      'number': 5,
      'category': 'History',
      'image':
          'https://i.natgeofe.com/k/1bc6572d-cb59-48b4-8d95-3e3a0f3c1b8a/history-og_16x9.jpg?w=1200',
      'question': 'What is the capital of France?',
    },
    {
      'number': 6,
      'category': 'Literature',
      'image':
          'https://nationaltoday.com/wp-content/uploads/2022/06/4-Literature.jpg',
      'question':
          'Who is the main character in the book To Kill a Mockingbird?',
    },
    {
      'number': 7,
      'category': 'Geography',
      'image':
          'https://www.redeemer.ca/wp-content/uploads/program-geography-social-share.jpg',
      'question': 'What is the largest ocean on Earth?',
    },
    {
      'number': 8,
      'category': 'History',
      'image':
          'https://i.natgeofe.com/k/1bc6572d-cb59-48b4-8d95-3e3a0f3c1b8a/history-og_16x9.jpg?w=1200',
      'question': 'Who discovered America?',
    },
    {
      'number': 9,
      'category': 'Geography',
      'image':
          'https://www.redeemer.ca/wp-content/uploads/program-geography-social-share.jpg',
      'question': 'What is the currency used in Japan?',
    },
    {
      'number': 10,
      'category': 'Art',
      'image':
          'https://guardian.ng/wp-content/uploads/2022/12/African-art-scaled.jpeg',
      'question': 'Who composed the opera The Barber of Seville"',
    },
    {
      'number': 11,
      'category': 'Geography',
      'image':
          'https://www.redeemer.ca/wp-content/uploads/program-geography-social-share.jpg',
      'question': 'What is the highest mountain in the solar system?',
    },
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
                  constraints.maxWidth > 393 ? Axis.horizontal : Axis.vertical,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12, width: 12),
              itemCount: questions.length,
              itemBuilder: (BuildContext context, int index) {
                return QuestionContainer(
                  question: questions[index]['question'],
                  questionCategory: questions[index]['category'],
                  questionNumnber: questions[index]['number'],
                  image: questions[index]['image'],
                );
              },
            );
          }),
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
  const QuestionContainer({
    super.key,
    required this.question,
    required this.questionCategory,
    required this.questionNumnber,
    required this.image,
  });

  final int questionNumnber;
  final String questionCategory;
  final String question;
  final String image;

  @override
  Widget build(BuildContext context) {
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
                        questionCategory,
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
                        image: NetworkImage(image), fit: BoxFit.cover),
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
