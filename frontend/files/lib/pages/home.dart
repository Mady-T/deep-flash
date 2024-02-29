import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fitness/models/deck_model.dart';

import 'about.dart';
import 'package:hive/hive.dart';
import 'deck.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedDeckIndex = -1;
  List<Deck> userdecks = [];
  // ignore: non_constant_identifier_names
  Box<Deck> DeckBox = Hive.box<Deck>('decks');
  //final decksdata = Hive.box('userdata');

  _HomePageState() {
    userdecks = DeckBox.values.toList();
    /*
    for (var i = 0; i < DeckBox.length; i++) {
      try {
        Deck data = DeckBox.getAt(i);
        print('Data at index $i: $data');
        userdecks.add(data);
      } on TypeError catch (_) {}
    }   */
  }

  Deck createDeck(String deckname) {
    Deck newdeck = Deck(name: deckname);
    userdecks.add(newdeck);
    DeckBox.put(deckname, newdeck);
    //decksdata.close();
    setState(() {});
    return newdeck;
  }

  @override
  Widget build(BuildContext context) {
    String iconPath = 'assets/icons/deck.svg';
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
            child: Text(
              'Your Decks',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 15),
          ListView.separated(
            itemCount: userdecks.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CardPage(deck: userdecks[index])));
                },
                onLongPress: () {
                  setState(() {
                    selectedDeckIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: selectedDeckIndex == index
                        ? const Color.fromARGB(255, 178, 174, 174)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        iconPath,
                        width: 65,
                        height: 65,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userdecks[index].name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${userdecks[index].difficulty} | ${userdecks[index].cards} | ${userdecks[index].timespent}',
                            style: const TextStyle(
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add_box),
                    title: const Text('Create New Deck'),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController deckNameController =
                              TextEditingController();

                          return AlertDialog(
                            title: const Text('Create New Deck'),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: TextField(
                                controller: deckNameController,
                                decoration: const InputDecoration(
                                    labelText: 'Deck Name'),
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
                                  String deckName = deckNameController.text;
                                  Deck newdeck = createDeck(deckName);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              CardPage(deck: newdeck)));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Deck Created successfully!'),
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
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Another Option'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add), // Set the background color of the button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
    // Use 'endFloat' for bottom-right corner, you can explore other options
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search Deck',
            hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/icons/Search.svg'),
            ),
            suffixIcon: SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/Filter.svg'),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Testapp',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
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
            color: const Color.fromARGB(255, 244, 244, 244),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          color: const Color.fromARGB(255, 244, 244, 244),
          onSelected: (value) {
            switch (value) {
              case 'faq':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FAQPage(),
                  ),
                );
                break;
              case 'about':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUsPage(),
                  ),
                );
                break;
              case 'contact':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactUsPage(),
                  ),
                );
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'faq',
              child: Text('FAQ'),
            ),
            const PopupMenuItem<String>(
              value: 'about',
              child: Text('About Us'),
            ),
            const PopupMenuItem<String>(
              value: 'contact',
              child: Text('Contact Us'),
            ),
          ],
          icon: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
          ),
        ),
      ],
    );
  }
}
