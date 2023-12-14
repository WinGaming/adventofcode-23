import 'package:day13/part1.dart';
import 'package:day13/part2.dart';

void main(List<String> arguments) async {
    if (arguments.first == "part1") {
        part1(arguments[1]);
    } else if (arguments.first == "part2") {
        part2(arguments[1]);
    } else {
        print("Unknown subprogram!");
    }
}
