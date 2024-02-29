import 'package:hive/hive.dart';
part 'deck_model.g.dart';

//run: flutter packages pub run build_runner build

@HiveType(typeId: 0)
class Deck {
  @HiveField(0)
  final String name;
  @HiveField(1)
  List<Card>? cards;
  @HiveField(2)
  String? difficulty;
  @HiveField(3)
  int timespent;

  int currentCount = 0;

  Deck({required this.name, this.difficulty, this.cards, this.timespent = 0});

  int deckLen() {
    return cards?.length ?? 0;
  }

  Card? getCardfromID(String cardId) {
    for (Card card in cards!) {
      if (card.id == cardId) return card;
    }
    return null;
  }

  void addCard(String question, String answer, num item_difficulty) {
    String id = (currentCount + 1).toString();
    Card newCard = Card(
        id: id,
        question: question,
        answer: answer,
        item_difficulty: item_difficulty);
    cards ??= [];
    cards!.add(newCard);
    currentCount += 1;
  }

  String nextCard() {
    if (cards != null) {
      List<num> weights = [0.8, -0.4, -1];
      Card? maxcard;
      num score = 0, maxscore = -999;
      for (Card card in cards!) {
        score = card.item_difficulty * weights[0] +
            card.memory_strength * weights[1] +
            card.last_shown * weights[2];
        if (score > maxscore) {
          maxcard = card;
          maxscore = score;
        }
      }
      return maxcard!.id;
    } else {
      return "";
    }
  }
}

// ignore_for_file: non_constant_identifier_names

class Card {
  final String id;
  final String question;
  final String answer;
  num item_difficulty;
  num memory_strength;
  num last_shown;

  Card({
    required this.id,
    required this.question,
    required this.answer,
    this.item_difficulty = 0,
    this.memory_strength = 0,
    this.last_shown = -1,
  });
}
