 /* кружка и человек, человек может пить из кружки 
 class Cup{
  String name;

  Cup(this.name);
 }

 class Persona{
  String personName;
  Persona(this.personName);

  void drink(Cup c)
  {
    print("буль буль буль, $personName пьет из ${c.name}  кружк(и/а)");
  } 
}
void main(){
  Cup cu = Cup("стремная");
  Persona p = Persona("ЕГорка");
  p.drink(cu);
}*/
/*Задача 2 - шкаф с вещами, чТО ЗНАЧИТ НЕСКОЛЬКО СИСТЕМ ХРАНЕНИЯ?  
import 'dart:io';

class Shkaf{
  List<String> into = [];



  void add(){
    print("Введите");
    String ins = stdin.readLineSync()!;
    into.add(ins);
    print("добавленно: $ins");
  }
  void rem(){
    print("Введите");
    String ins = stdin.readLineSync()!;
    into.remove(ins);
    print("$ins удалено");
  }

  void show(){
    print("вот что лежит в шкафу:");
      print(into);
  }

}
void menu(){
  print(" == Шкаф == ");
  print("== 1 - Добавить == ");
  print("== 2 - Убрать ==");
  print(" == 3 - Показать == ");
  print(" == 0 - Выход == ");
}
void main(){
  bool brck = true;
  Shkaf garderob = Shkaf();
  menu();
  while(brck){
    int ch = int.parse(stdin.readLineSync()!);
    switch(ch){
      case (1):
        garderob.add();
        menu();
      break;
      case (2):
      garderob.rem();
      menu();
      break;
      case (3):
      garderob.show();
      menu();
      break;
      case(0):
      brck = false;
      break;
    }
  }
}
*/
/* задача с блинами и грифом, спортсменская короче, НОМЕР 3

import 'dart:io';

class Blin{
  String size;
  int weight;
  Blin(this.size,this.weight);
}

class Grif{
  int number;
  int gruz = 0;
  final maxWeight;
  bool chtk = true;
  Grif(this.number,this.maxWeight);

  void nakidBlinov(Blin b){
    if(gruz + (b.weight * 2) > maxWeight){
      print("ЭЭЭЭЭЭ КУДА, СПОРТСМЕН, ЩА ГРИФ ПОГНЕШЬ!");
      chtk = false;
    }
    
      int news = gruz +( b.weight * 2);
      gruz = news;
      print("На грифе $gruz кг");
    
  }
}
void main(){
  Grif gr = Grif(1,200 );
  Blin bl = Blin("Большой", 50);
  bool sas = true;
  while(sas){
    print("Накинуть блинов?(Да - 1/Нет - 0)");
    int ch = int.parse(stdin.readLineSync()!);
     switch(ch){
      case (1):
        gr.nakidBlinov(bl);
        if(gr.chtk == false){
          sas = false;
        }
      break;
      case (0):
      sas = false;
      break;
      }
  }
  
  
}*/
/*Задача НОМЕР 4  
class Money{
  double money;
  static Map<String, double> curs= {
    "Доллары":74.44,
    "Евро":102.22
  };
  Money(this.money);

  static void convertRToUSD(Money m){
    double result = m.money / curs["Доллары"]!;
    print(result);
  }
  static void convertRtoEURO(Money m){
    double result = m.money  / curs["Евро"]!;
    print(result);
  }
}
void main(){
  Money rub = Money(100);
  print("В баксы:");
  Money.convertRToUSD(rub);
  print("В евро:");
  Money.convertRtoEURO(rub);
}
*/

/*ЗАдача НОМЕР 5 СТОП, пятый пропущен? значит 6 */
// хз что придумать с перегрузкой
/*Задача 6(7) тачка короче, 
class Auto{
  String name;
  State st = State.stop;
  
  void start(){
    st = State.start;
    print("Машина поехала");
  }
  void move(){
    st = State.start;
    print("Машина повернула");
  }
  void stop(){
    st = State.stop;
    print("Машина стоп");
  }
   void showState() {
    print("Текущее состояние: $st");
  }
  Auto(this.name)
}
enum State {
    stop,
    start,
    move;
  }
  void main(){
    Auto av = Auto("sas");
    av.start();
    av.stop();
    av.move();
  }
  */
/*я просто стырю с кассного кода)
abstract class Shepe{
  void show(){}  //надо все переопределить через @override обязательно!
  void area(){}// просто класс с функциями без реализации 


}
class Rect extends Shepe{
  @override
  String? name;
  int a;
  Rect(this.name,this.a);

  @override
  void show(){  
    print("$name");
  }
  @override
  void area(){
    print("${a*a}");
  }
}
class Priamougol extends Shepe{
  @override
  String? name;
  int a;
  int b;

  Priamougol(this.name,this.a, this.b);

  @override
  void show(){  
    print("object");
  }
  @override
  void area(){
    print("${a*b}");
  }
}
void main() {
  Rect r = Rect("sas", 4);
  Priamougol p = Priamougol("sasasas", 6,12);

  print("Квадрат");
  r.area();
  print("Прямокгольник:");
  p.area();
}*/
/*
class Converter {
  String convert(String number, int fromBase, int toBase) {
    int decimal = int.parse(number, radix: fromBase);
    return decimal.toRadixString(toBase);
  }
}

void main() {
  Converter c = Converter();

  print(c.convert("1010", 2, 10)); // 10
  print(c.convert("15", 10, 2));   // 1111
}
*/
/*
class ShapeManager {
  List<double> areas = [];

  void add(double area) {
    areas.add(area);
  }

  double maxArea() {
    double max = areas[0];

    for (var a in areas) {
      if (a > max) {
        max = a;
      }
    }

    return max;
  }
}

void main() {
  ShapeManager m = ShapeManager();

  m.add(6);
  m.add(12);
  m.add(9);

  print("Максимум: ${m.maxArea()}");
}*/
class Table {
  List<String> items = [];

  void add(String item) {
    items.add(item);
  }

  void remove(String item) {
    items.remove(item);
  }

  void show() {
    for (var i in items) {
      print(i);
    }
  }
}

void main() {
  Table table = Table();

  table.add("Вилка");
  table.add("Ложка");
  table.add("Нож");

  print("На столе:");
  table.show();

  table.remove("Ложка");

  print("\nПосле удаления:");
  table.show();
}