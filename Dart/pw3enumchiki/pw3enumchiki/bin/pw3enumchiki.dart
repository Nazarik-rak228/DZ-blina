import 'dart:io';
import 'dart:math';

import 'dart:convert';



void main() {
  print("=== Генератор настроения ===");
  stdout.write("Введите ваше имя: ");// так красивее, 
  String name = stdin.readLineSync()!;


  final randomMood = Mood.values[Random().nextInt(Mood.values.length)]; //выбор рандомного состояния

  print("\nПривет, $name!");
  print("Твое настроение: ${randomMood.emoji} ${randomMood.description} ""(энергия: ${randomMood.energy}/10)");


  int codePoint = randomMood.emoji.runes.first;
  print(
      "Unicode эмодзи: U+${codePoint.toRadixString(16)}");


  //сложные эмодзи
  stdout.write("\nХотите проанализировать сложные эмодзи? (yes/no): ");
  String otvet = (stdin.readLineSync()!).toLowerCase();

  if (otvet == "yes") {
    print("Введите комбинацию эмодзи: ");
    var text = stdin.readLineSync(encoding: utf8)!;

    print('Анализ строки');

    print("16битный: ${text.length}");
    print("Кодовых точек: ${text.runes.length}");
    print("Реальных символов: ${text.runes.length}");

    print("Подробный вывод юникода:");

    var i = 1;
    for (var rune in text.runes) {
      var symbol = String.fromCharCode(rune);
      var unicode = "U+${rune.toRadixString(16).toUpperCase().padLeft(6, '0')}";

      print("Символ $i: $symbol ($unicode)");
      i++;
    }
  }
}

// Перечисление настроений
enum Mood {
  happy("\u{1F600}", "Счастливое", 9),
  sad("\u{1F622}", "Грустное", 3),
  angry("\u{1F620}", "Злое", 7),
  sleepy("\u{1F62A}", "Сонное", 2),
  cool("\u{1F60E}", "Крутое", 8);

  final String emoji;
  final String description;
  final int energy;

  const Mood(this.emoji, this.description, this.energy);
}