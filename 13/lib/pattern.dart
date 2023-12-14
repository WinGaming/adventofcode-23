class Pattern {

    MirrorDirection? mirrorDirection;
    int? mirrorIndex;

    List<String> lines;

    Pattern(this.lines);
}

enum MirrorDirection {

    column, row

}