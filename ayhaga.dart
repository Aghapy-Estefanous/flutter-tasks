//import 'dart:ffi';
//import 'dart:io';
int sum(List<int> l) {
  return l.reduce((value, element) => value + element);
}

//mapper
List<int> custom_map(List<int> l, int Function(int el) f, bool b) {
  List<int> ll = [];
  if (b) {
    for (var item = 0; item < l.length; item++) l[item] = f(l[item]);
    return l;
  } else {
    for (var item = 0; item < l.length; item++) ll.add(f(l[item]));
    return ll;
  }
}

//custom any
bool custom_any(List<int> l, bool Function(int el) f) {
  //bool flag = false;
  for (var item = 0; item < l.length; item++)
    if (f(l[item])) {
      return true;
    }
  return false;
}

//custom every
bool custom_every(List<int> l, bool Function(int el) f) {
  //bool flag = false;
  for (var item = 0; item < l.length; item++)
    if (!f(l[item])) {
      return false;
    }
  return true;
}

//custom some
bool custom_some(List<int> l, bool Function(int el) f) {
  bool flag = false;
  for (var item = 0; item < l.length; item++)
    if (f(l[item]) && flag == true) {
      return true;
    } else if (f(l[item])) flag = true;
  return false;
}

int custom_reduce(List<int> l, int Function(int el, int acc) f, int ac) {
  var re = 0;
  for (var item = 0; item < l.length; item++) {
    re = f(l[item], re);
  }
  return re;
}

int main() {
  var num = [5, 2, 3, 2, 4, 1];
  //print(num.reduce((value, element) => value * element)); // fold
  //print(sum(num));

  //print(num.map((e) => if(e%2==0) ));
  //num.where();
  print(custom_any(num, ((el) => el == 2)));
  print(custom_every(num, ((el) => el == 2)));
  print(custom_some(num, ((el) => el == 2)));

  print(custom_reduce(num, (acc, el) {
    return el + acc;
  }, 15));
  print(custom_map(num, (el) => el * 2, false));
  print(num);
  return 0;
}
