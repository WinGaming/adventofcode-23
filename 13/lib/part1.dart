import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:day13/pattern.dart';

void solvePattern(Pattern pattern) {
    if (pattern.mirrorDirection != null && pattern.mirrorIndex != null) return;

    for (int i = 1; i < pattern.lines.length; i++) {
        if (checkRowMirror(pattern, i)) {
            pattern.mirrorDirection = MirrorDirection.row;
            pattern.mirrorIndex = i; // i is also equal to the number of rows above the mirror, so we can just use it
            return;
        }
    }

    for (int i = 1; i < pattern.lines.first.length; i++) {
        if (checkColumnMirror(pattern, i)) {
            pattern.mirrorDirection = MirrorDirection.column;
            pattern.mirrorIndex = i; // i is also equal to the number of colomns left of the mirror, so we can just use it
            return;
        }
    }
}

bool checkColumnMirror(Pattern pattern, int index) {
    for (int i = 0; i < min(index, pattern.lines.first.length - index); i++) {
        int columnUp = index + i;
        int columnDown = index - (i + 1);

        for (int y = 0; y < pattern.lines.length; y++) {
            if (pattern.lines[y][columnDown] != pattern.lines[y][columnUp]) {
                return false;
            }
        }
    }

    return true;
}

bool checkRowMirror(Pattern pattern, int index) {
    for (int i = 0; i < min(index, pattern.lines.length - index); i++) {
        int rowUp = index + i;
        int rowDown = index - (i + 1);

        // print("$rowDown -> $rowUp = ${pattern.lines[rowDown]} | ${pattern.lines[rowUp]}");

        if (pattern.lines[rowDown] != pattern.lines[rowUp]) return false;
    }

    return true;
}

void part1(String path) async {
    final file = File(path);
    Stream<String> lines = file.openRead().transform(utf8.decoder).transform(LineSplitter());

    try {
        List<Pattern> patterns = [];
        List<String> currentPattern = [];
        await for (var line in lines) {
            if (line.isNotEmpty) {
                currentPattern.add(line);
            } else if (currentPattern.isNotEmpty) {
                patterns.add(Pattern(currentPattern));
                currentPattern = [];
            }
        }

        if (currentPattern.isNotEmpty) {
            patterns.add(Pattern(currentPattern));
        }

        patterns.forEach(solvePattern);

        int rowTotal = 0;
        int colomnTotal = 0;
        for (var element in patterns) {
            if (element.mirrorDirection == null || element.mirrorIndex == null) throw "Found unresolved Pattern instance";

            if (element.mirrorDirection == MirrorDirection.column) {
                colomnTotal += element.mirrorIndex ?? 0;
            } else {
                rowTotal += element.mirrorIndex ?? 0;
            }
        }

        print("$colomnTotal + $rowTotal * 100 = ${colomnTotal + rowTotal * 100}");
    } catch (e) {
        print("Error: $e");
    }
}
