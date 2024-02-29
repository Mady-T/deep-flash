import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fitness/models/deck_model.dart';
import 'learn.dart';

class CardPage extends StatefulWidget {
  final Deck deck;

  const CardPage({Key? key, required this.deck}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<CardPage> createState() => _CardPageState(deck);
}

class _CardPageState extends State<CardPage> {
  Deck deck;
  _CardPageState(this.deck);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: appBar(context, widget.deck.name),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Deck details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Difficulty: ${deck.difficulty}",
              style: const TextStyle(fontSize: 22),
            ),
            const Divider(thickness: 2, color: Colors.grey),
            Text(
              "Cards: ${deck.deckLen()}",
              style: const TextStyle(fontSize: 22),
            ),
            const Divider(thickness: 2, color: Colors.grey),
            Text(
              "Time Spent: ${deck.timespent} minutes",
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'addCard',
          onPressed: () {
            addNewCard(context, deck);
          },
          backgroundColor: Colors.blueGrey,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'editDeck',
          onPressed: () {},
          backgroundColor: Colors.blueGrey,
          child: const Icon(Icons.edit, color: Colors.white),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 200,
          child: FloatingActionButton(
            heroTag: 'startLearn',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FlipCard(deck: deck)),
              );
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.play_arrow, color: Colors.white),
          ),
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }

  AppBar appBar(BuildContext context, String deckname) {
    return AppBar(
      title: Text(
        deckname,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Pop the current screen
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }

  Future<dynamic> addNewCard(BuildContext context, Deck deck) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController question = TextEditingController();
        TextEditingController answer = TextEditingController();
        num difficulty = 0;

        return AlertDialog(
          title: const Text('Add new Card'),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: question,
                    decoration: const InputDecoration(labelText: 'Question'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: answer,
                    decoration: const InputDecoration(labelText: 'Answer'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Difficulty",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        SizedBox(
                          width: 40, // Adjust the width as needed
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              // Add your logic here
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF44CE1B),
                              padding: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "1",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40, // Adjust the width as needed
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              // Add your logic here
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFbbdb44),
                              padding: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "2",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40, // Adjust the width as needed
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              // Add your logic here
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFf7e379),
                              padding: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "3",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40, // Adjust the width as needed
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              // Add your logic here
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFf2a134),
                              padding: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "4",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40, // Adjust the width as needed
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              // Add your logic here
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFe51f1f),
                              padding: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "5",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                print('Deck ${deck} ${deck.name}, ${deck.cards}');
                deck.addCard(question.text, answer.text, difficulty);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Card added successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
