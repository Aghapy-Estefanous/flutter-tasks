// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../imports.dart';

class Reviews {
  String id;
  String pro_id;
  String user_id;
  String review_title;
  String review_content;
  String review_rate;

  Reviews(
    this.pro_id,
    this.user_id,
    this.review_title,
    this.review_content,
    this.review_rate,
  ) : id = generateProId() {
    addReveiwtoProduct(id);
  }
  static String generateProId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pro_id': pro_id,
      'user_id': user_id,
      'review_title': review_title,
      'review_content': review_content,
      'review_rate': review_rate
    };
  }
}

Future<void> savereviewDataToCsv(Reviews pro) async {
  String csvFilePath = 'assets/reviews.csv';
  File file = File(csvFilePath);

  if (!file.existsSync()) {
    file.writeAsStringSync(
        'id,product_id,user_id,review_title,review_content,review_rate,\n');
  }

  file.writeAsStringSync(
      '${pro.id},${pro.pro_id},${pro.user_id},${pro.review_title},${pro.review_content},${pro.review_rate},\n',
      mode: FileMode.append);
}

Future<void> showReview(String id) async {
  String csvFilePath = 'assets/reviews.csv';
  File input = File(csvFilePath);

  bool flag = false;
  String csvString = await input.readAsString();
  List<String> rows = csvString.split('\n');
  for (String row in rows) {
    List<String> values = row.split(',');
    if (values.length >= 3 && values[0] == id) {
      flag = true;
      print(
          "id :${values[0]} product id :${values[1]} ,user id :${values[2]} ,review_title : ${values[3]} ,review_content :${values[4]} ,review_rate:${values[5]}");
    }
  }
  if (flag == false) print("Product Not found");
}

Future<void> showAllReveiwes() async {
  String csvFilePath = 'assets/reviews.csv';
  File input = File(csvFilePath);

  String csvString = await input.readAsString();
  List<String> rows = csvString.split('\n');
  for (String row in rows) {
    List<String> values = row.split(',');
    if (values[0] == "id") continue;
    if (values.length >= 3) {
      print(
          "id :${values[0]} ,product id :${values[1]} ,user id :${values[2]} ,review_title : ${values[3]} ,review_content :${values[4]} ,review_rate:${values[5]}");
    }
  }
}

Future<void> removereview(String id) async {
  String csvFilePath = 'assets/reviews.csv';
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

Future<void> updatereview(String id) async {
  String csvFilePath = 'assets/reviews.csv';
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
      print("enter product id :");
      String? proId = stdin.readLineSync()!;
      print("enter user id :");
      String? userId = stdin.readLineSync()!;
      print("enter review_title:");
      String? review_title = stdin.readLineSync()!;
      print("enter review_content:");
      String? review_content = stdin.readLineSync()!;
      print("enter review_rate:");
      String? review_rate = stdin.readLineSync()!;
      input.writeAsStringSync(
          '${id},${proId},${userId},${review_title},${review_content},${review_rate}\n',
          mode: FileMode.append);
      print("Row with ID $id updated");
      break;
    } else
      i++;
  }

  if (flag == false) print("Not found");
}
