import 'package:flutter/material.dart';
import 'package:fitness/models/deck_model.dart' as deck_card;
import 'package:flutter_svg/flutter_svg.dart';


class FlipCard extends StatefulWidget {
  final deck_card.Deck deck;

  const FlipCard({Key? key, required this.deck}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<FlipCard> createState() => _FlipCardState(deck);
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  deck_card.Deck deck;
  deck_card.Card? currcard;
  _FlipCardState(this.deck);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    currcard = deck.getCardfromID(deck.nextCard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              'assets/icons/cross.svg',
              height: 20,
              width: 20,
            ),
          ),
        ),
      ),
      body: Center(
          child: GestureDetector(
        onTap: () {
          if (_animationController.isCompleted) {
            _animationController.reverse();
          } else {
            _animationController.forward();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(_animation.value * 3.14),
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: Container(
                width: 300,
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      "Card Front",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      )),
    );
  }
}
