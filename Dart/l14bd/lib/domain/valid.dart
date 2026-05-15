String requareParametr(String? val, String fiel ){
  if (val == null || val.trim().isEmpty){
    throw Exception("$fiel пуст! ");
  }
  return val.trim();
}
String checkEmail(String? text, String fieldName) {
  if (text == null || text.trim().isEmpty) {
    throw Exception('$fieldName не может быть пустым');
  }
  
  var email = text.trim();
  if (!email.contains('@') || !email.contains('.')) {
    throw Exception('Неправильный email');
  }
  
  return email;
}

DateTime checkDate(String? text, String fieldName) {
  if (text == null || text.trim().isEmpty) {
    throw Exception('$fieldName не может быть пустым');
  }
  try {
    return DateTime.parse(text.trim());
  } catch (e) {
    throw Exception('Дата должна быть в формате YYYY-MM-DD');
  }
}