import '../imports.dart';
import 'package:dart/classes/reviews.dart';

class Product {
  String id;
  String name;
  String price;
  String ItemsInStock;
  List<Reviews>? review;

  Product(
    this.name,
    this.price,
    this.ItemsInStock,
  ) : id = generateProId();

  static String generateProId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'ItemsInStock': ItemsInStock,
      'reviews': review,
    };
  }
}

Future<void> showPro(String id) async {
  String csvFilePath = 'assets/product.csv';
  File input = File(csvFilePath);

  bool flag = false;
  String csvString = await input.readAsString();
  List<String> rows = csvString.split('\n');
  for (String row in rows) {
    List<String> values = row.split(',');
    if (values.length >= 3 && values[0] == id) {
      flag = true;
      print(
          "id :${values[0]} ,name :${values[1]} ,price : ${values[2]} ,items in stock :${values[3]}");
    }
  }
  if (flag == false) print("Product Not found");
}

Future<void> updatePro(String id) async {
  String csvFilePath = 'assets/product.csv';
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
      print("enter product name :");
      String? name = stdin.readLineSync()!;
      print("enter product price :");
      String? price = stdin.readLineSync()!;
      print("enter product Items in stock :");
      String? IIS = stdin.readLineSync()!;
      input.writeAsStringSync('${id},${name},${price},${IIS}\n',
          mode: FileMode.append);
      print("Row with ID $id updated");
      break;
    } else
      i++;
  }

  if (flag == false) print("Not found");
}

Future<void> saveProDataToCsv(Product pro) async {
  String csvFilePath = 'assets/product.csv';
  File file = File(csvFilePath);

  if (!file.existsSync()) {
    file.writeAsStringSync('id,name,price,items in stock,reviews\n');
  }

  file.writeAsStringSync(
      '${pro.id},${pro.name},${pro.price},${pro.ItemsInStock},\n',
      mode: FileMode.append);
}

Future<void> showAllPros() async {
  String csvFilePath = 'assets/product.csv';
  File input = File(csvFilePath);

  String csvString = await input.readAsString();
  List<String> rows = csvString.split('\n');
  for (String row in rows) {
    List<String> values = row.split(',');
    if (values[0] == "id") continue;
    if (values.length >= 3) {
       print(
          "id :${values[0]} ,name :${values[1]} ,price : ${values[2]} ,items in stock :${values[3]}");
    }
  }
}

Future<void> removePro(String id) async {
  String csvFilePath = 'assets/product.csv';
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

void addReveiwtoProduct(String id) {
  
}

Future<Product> getProduct(String id) async {
  String csvFilePath = 'assets/product.csv';
  File input = File(csvFilePath);

  bool flag = false;
  String csvString = await input.readAsString();
  List<String> rows = csvString.split('\n');
  for (String row in rows) {
    List<String> values = row.split(',');
    if (values.length >= 3 && values[0] == id) {
      flag = true;
      Product pro = Product(values[1], values[2], values[3]);
      pro.id = values[0];
      return pro;
    }
  }
  if (flag == false) print("Product Not found");
  return Product("", "", "");
}
