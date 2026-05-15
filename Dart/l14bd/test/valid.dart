import 'package:l14bd/domain/user.dart';
import 'package:l14bd/Data/user-repo.dart';
import 'package:l14bd/domain/valid.dart';
import 'package:l14bd/Data/database.dart';
void main() async {
  print('ЗАПУСК ТЕСТОВ\n');

  print('Тесты: requareParametr');

  try {
    var result = requareParametr('  Иван  ', 'Имя');

    print(result == 'Иван'
        ? 'Тест 1 пройден'
        : 'Тест 1 провален');
  } catch (e) {
    print('Тест 1 провален');
  }

  try {
    requareParametr('', 'Имя');

    print('Тест 2 провален');
  } catch (e) {
    print('Тест 2 пройден');
  }

  print('\nТесты: checkEmail');

  try {
    var result = checkEmail('test@test.com', 'Email');

    print(result == 'test@test.com'
        ? 'Тест 3 пройден'
        : 'Тест 3 провален');
  } catch (e) {
    print('Тест 3 провален');
  }

  try {
    checkEmail('wrongEmail', 'Email');

    print('Тест 4 провален');
  } catch (e) {
    print('Тест 4 пройден');
  }

  print('\nТесты: checkDate');

  try {
    var result = checkDate('2026-05-14', 'Дата');

    print(result is DateTime
        ? 'Тест 5 пройден'
        : 'Тест 5 провален');
  } catch (e) {
    print('Тест 5 провален');
  }

  try {
    checkDate('не дата', 'Дата');

    print('Тест 6 провален');
  } catch (e) {
    print('Тест 6 пройден');
  }
  print('\n=== ТЕСТЫ БД ===');

try {
  var user = User(
    id: '1',
    fullName: 'Ivan',
    email: 'ivan@test.com',
    login: 'ivan',
    password: '123',
    roleId: 'admin',
    createdAt: DateTime.now().toString(),
  );

  insertUser(user);

  print('Тест 7 пройден');
} catch (e) {
  print('Тест 7 провален');
}

try {
  var users = getAllUsers();

  if (users.isNotEmpty) {
    print('Тест 8 пройден');
  } else {
    print('Тест 8 провален');
  }
} catch (e) {
  print('Тест 8 провален');
}

try {
  var user = getUser('1');

  if (user != null) {
    print('Тест 9 пройден');
  } else {
    print('Тест 9 провален');
  }
} catch (e) {
  print('Тест 9 провален');
}
try {
  var oldUser = getUser('1');

  if (oldUser != null) {
    var updatedUser = User(
      id: oldUser.id,
      fullName: 'New Name',
      email: oldUser.email,
      login: oldUser.login,
      password: oldUser.password,
      roleId: oldUser.roleId,
      createdAt: oldUser.createdAt,
    );

    updateUser(updatedUser);

    print('Тест 10 пройден');
  } else {
    print('Тест 10 провален');
  }
} catch (e) {
  print('Тест 10 провален');
}

try {
  var user = getUser('1');

  if (user != null) {
    deleteUser(user);

    print('Тест 11 пройден');
  } else {
    print('Тест 11 провален');
  }
} catch (e) {
  print('Тест 11 провален');
}

disposeDb();

}