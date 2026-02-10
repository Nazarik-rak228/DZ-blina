// data-utils.js

const users = [
  { id: 1, name: "Anna", age: 22, city: "Moscow", isActive: true },
  { id: 2, name: "Oleg", age: 17, city: "Kazan", isActive: false },
  { id: 3, name: "Ivan", age: 30, city: "Moscow", isActive: true },
  { id: 4, name: "Maria", age: 25, city: "Sochi", isActive: false }
];

// 1. Фильтрация активных пользователей
function getActiveUsers(users) {
  return users.filter(user => user.isActive);
}

// 2. Получение только имён (стрелочная функция)
const getUserNames = users => users.map(user => user.name);

// 3. Поиск пользователя по id
function findUserById(users, id) {
  return users.find(user => user.id === id) || null;
}

// 4. Статистика
function getUsersStatistics(users) {
  const active = users.filter(u => u.isActive).length;
  return {
    total: users.length,
    active: active,
    inactive: users.length - active
  };
}

// 5. Средний возраст
function getAverageAge(users) {
  if (!users.length) return 0;
  const sum = users.reduce((acc, u) => acc + u.age, 0);
  return Number((sum / users.length).toFixed(1));
}

// 6. Группировка по городам 
function groupUsersByCity(users) {
  return users.reduce((acc, user) => {
    const city = user.city;
    if (!acc[city]) {
      acc[city] = [];
    }
    acc[city].push(user);
    return acc;
  }, {});
}

// --------------------вывод

console.log("Активные пользователи:");
console.log(getActiveUsers(users));

console.log("\nИмена всех пользователей:");
console.log(getUserNames(users));

console.log("\nПользователь с id 3:");
console.log(findUserById(users, 3));

console.log("\nПользователь с id 999:");
console.log(findUserById(users, 999));

console.log("\nСтатистика:");
console.log(getUsersStatistics(users));

console.log("\nСредний возраст:");
console.log(getAverageAge(users));

console.log("\nГруппировка по городам:");
console.log(groupUsersByCity(users));
