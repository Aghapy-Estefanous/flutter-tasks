import '../imports.dart';
//import 'package:csv/csv.dart';

class User {
  String id;
  String name;
  String email;
  String? password;

  User(this.name, this.email, this.password) : id = generateUserId();

  static String generateUserId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

Future<void> showUser(String id) async {
  String csvFilePath = 'assets/userData.csv';
  File input = File(csvFilePath);

  bool flag = false;
  String csvString = await input.readAsString();
  List<String> rows = csvString.split('\n');
  for (String row in rows) {
    List<String> values = row.split(',');
    if (values.length >= 3 && values[0] == id) {
      flag = true;
      print(
          "id :${values[0]} name :${values[1]} Email: ${values[2]}  password :${values[3]}");
    }
  }

  if (flag == false) print("Not found");
}

Future<void> updateUser(String id) async {
  String csvFilePath = 'assets/userData.csv';
  File input = File(csvFilePath);

  bool flag = false;
  String csvString = await input.readAsString();
  List<String> rows = csvString.split('\n');
  var i = 0;
  for (String row in rows) {
    List<String> values = row.split(',');
    if (values.length >= 3 && values[0] == id) {
      flag = true;
      rows.removeAt(i); // Remove the row
      input.writeAsStringSync(rows.join('\n'),
          mode: FileMode
              .write); // Write the updated CSV data without the removed row
      print("enter your name :");
      String? name = stdin.readLineSync()!;
      print("enter your E-mail :");
      String? email = stdin.readLineSync()!;
      print("enter your password :");
      String? password = stdin.readLineSync()!;
      input.writeAsStringSync('${id},${name},${email},${password}\n',
          mode: FileMode.append);
      print("Row with ID $id updated");
      break;
    } else
      i++;
  }

  if (flag == false) print("Not found");
}

Future<void> showAllUsers() async {
  String csvFilePath = 'assets/userData.csv';
  File input = File(csvFilePath);

  String csvString = await input.readAsString();
  List<String> rows = csvString.split('\n');
  for (String row in rows) {
    List<String> values = row.split(',');
    if (values[0] == "id") continue;
    if (values.length >= 3) {
      print(
          "id: ${values[0]} name: ${values[1]} Email: ${values[2]} password :${values[3]}");
    }
  }
}

Future<void> saveUserDataToCsv(User user) async {
  String csvFilePath = 'assets/userData.csv';
  File file = File(csvFilePath);

  if (!file.existsSync()) {
    file.writeAsStringSync('id,name,email,password\n');
  }

  file.writeAsStringSync(
      '${user.id},${user.name},${user.email},${user.password}\n',
      mode: FileMode.append);
}

Future<void> removeUser(String id) async {
  String csvFilePath = 'assets/userData.csv';
  File input = File(csvFilePath);

  bool flag = false;
  String csvString = await input.readAsString();
  List<String> rows = csvString.split('\n');
  var i = 0;
  for (String row in rows) {
    List<String> values = row.split(',');
    if (values.length >= 3 && values[0] == id) {
      flag = true;
      rows.removeAt(i); // Remove the row
      input.writeAsStringSync(rows.join('\n'),
          mode: FileMode
              .write); // Write the updated CSV data without the removed row
      print("Row with ID $id removed");
      break;
    } else
      i++;
  }

  if (flag == false) print("Not found");
}
