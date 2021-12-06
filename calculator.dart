import 'dart:io';
import 'dart:math';
import 'userinput.dart';

List<String> Step_of_collocation(String value) {
  List<String> collect = [];
  List<String> collect2 = [];
  int d = value.length;
  String join = "";
  for (int i = 0; i < d; i++) {
    if (value[i] == "+" ||
        value[i] == "-" ||
        value[i] == "*" ||
        value[i] == "/" ||
        value[i] == "^" ||
        value[i] == "(" ||
        value[i] == ")") {
      if (join == "") {
        //continue;
        collect.add(value[i]);
      } else {
        collect.add(join);
        collect.add(value[i]);
        join = "";
      }
    } else
      join += value[i];
  }
  if (join.length > 0) {
    collect.add(join);
  }
  return collect;
}

void step_of_simplication(String madila, List<String> v) {
  List<int> jam = [];
  List<int> manf = [];
  List<int> zarb = [];
  List<int> taq = [];
  List<int> twan = [];
  List<int> bazmos = [];
  List<int> bazman = [];
  List<int> baz = [];
  List<int> basta = [];
  bool bazbasta = false;
  for (int i = 0; i < v.length; i++) {
    if (v[i] == "+" && bazbasta == false) {
      jam.add(i);
    } else if (v[i] == "-" && bazbasta == false) {
      manf.add(i);
    } else if (v[i] == "*") {
      zarb.add(i);
    } else if (v[i] == "/") {
      taq.add(i);
    } else if (v[i] == "^") {
      twan.add(i);
    } else if (v[i] == "(") {
      baz.add(i);
      bazbasta = true;
    } else if (v[i] == ")") {
      basta.add(i);
      bazbasta = false;
    } else if (v[i] == "-" && bazbasta == true) {
      bazman.add(i);
    } else if (v[i] == "+" && bazbasta == true) {
      bazmos.add(i);
    } else {
      continue;
    }
  }

  List<String> l = [];
  l.addAll(v);
  // print(l);
  if (twan.length > 0) {
    num t = 1;
    for (int i = 0; i < twan.length; i++) {
      int a = int.tryParse(v[twan[i] - 1])!;
      int b = int.tryParse(v[twan[i] + 1])!;
      t = pow(a, b);
      l[twan[i] - 1] = t.toString();
      l[twan[i]] = "";
      l[twan[i] + 1] = "";
    }
    if (zarb.length == 0 &&
        baz.length == 0 &&
        taq.length == 0 &&
        jam.length == 0 &&
        manf.length == 0) {
      var end = l.where((element) => element != "");
      print(
          "......................................................................................");
      print("$madila = $end");
    }
  }
  if (zarb.length > 0) {
    int t = 1;
    for (int i = 0; i < zarb.length + 1; i++) {
      try {
        t *= int.tryParse(v[zarb[i] - 1])!; // * int.tryParse(v[zarb[i] + 1])!;
        l[zarb[i] - 1] = "";
        l[zarb[i]] = "";
        // l[zarb[i] + 1] = "";
      } catch (r) {
        t *= int.tryParse(v[zarb[i - 1] + 1])!;
        l[zarb[i - 1] + 1] = "";
        l[zarb[0] - 1] = t.toString();
      }
    }
    if (baz.length == 0 &&
        taq.length == 0 &&
        jam.length == 0 &&
        manf.length == 0) {
      print("$madila = $t");
    }
  }

  if (baz.length > 0) {
    int t = 0;
    for (int i = 0; i < baz.length; i++) {
      int man1 = 0;
      int mos1 = 0;
      int d1 = baz[i];
      int d2 = basta[i];
      if (bazmos.length < 1) bazmos.add(bazman[0] - 2);
      if (bazman.length > 0) {
        for (int d = d1; d < d2; d++) {
          if (l[d] == "-") {
            man1 -= int.tryParse(l[d + 1])!;
            l[d] = "";
            l[d + 1] = "";
          }
        }
      }
      if (bazmos.length > 0) {
        for (int d = d1; d < d2; d++) {
          if (l[d] != "" && l[d] != "+" && l[d] != "(" && l[d] != ")") {
            mos1 += int.tryParse(l[d])!;
            l[d] = "";
          }
        }

        t = man1 + mos1;
      }
      if (baz[0] != 0) {
        t = int.tryParse(l[baz[0] - 1])! * t;
        l[baz[i] - 1] = t.toString();
        l[baz[i]] = "";
        l[basta[i]] = "";
        t = 0;
      } else {
        l[baz[0]] = t.toString();
        t = 0;
      }
    }
    if (taq.length == 0 && jam.length == 0 && manf.length == 0) {
      print("$madila = ${l[0]}");
    }
  }

  if (taq.length > 0) {
    double t = 0;
    for (int i = 0; i < taq.length; i++) {
      try {
        t = double.tryParse(l[taq[i] - 1])! / double.tryParse(l[taq[i] + 1])!;
        l[taq[i] - 1] = t.toString();
        l[taq[i]] = "";
        l[taq[i] + 1] = "";
      } catch (r) {
        l.forEach((element) {
          if (element == l[zarb[0] - 1]) {
            t = double.tryParse(element)! / double.tryParse(l[taq[i] + 1])!;
          }
        });
      } finally {
        if (jam.length == 0 && manf.length == 0) {
          print("$madila = $t");
        }
        return;
      }
    }
  }

  if (jam.length > 0 || manf.length > 0) {
    int t = 0;
    int tmons = 0;
    for (int i = 0; i < l.length; i++) {
      if (l[i] == "-") {
        t -= int.tryParse(l[i + 1])!;
        l[i] = "";
        l[i + 1] = "";
      }
      // print("$madila = $t");
    }
    // print(l);
    for (int i = 0; i < l.length; i++) {
      if (l[i] != "+" && l[i] != "") {
        tmons += int.tryParse(l[i])!;
        // print(tmons);
      }
    }
    tmons = t + tmons;
    print("----------------------------------------");
    print("$madila = $tmons");
    print("----------------------------------------");
  }
}

void main(List<String> args) {
  while (true) {
    String s = user_input<String>(
        "Wlecom to aljabra \n enter << 0 >> for exit \nenter your mathmatic algoritm");
    if (s == "0")
      break;
    else {
      var t = Step_of_collocation(s);
      step_of_simplication(s, t);
    }
  }
}
