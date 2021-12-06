import 'dart:io';

T user_input<T>(String massege) {
  print(massege + ":");
  String? input = stdin.readLineSync();
  if (T == String)
    return input as T;
  else if (T == double)
    return double.tryParse(input!) as T;
  else if (T == int)
    return int.tryParse(input!) as T;
  else
    return null as T;
}
