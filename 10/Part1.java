import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class Part1 {

    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new FileReader(new File("input.txt")));
        String line = null;
        List<String> lines = new ArrayList<>();
        while ((line = reader.readLine()) != null) {
            lines.add(line);
        }
        reader.close();

        Coord start;
        char[][] fields = new char[lines.size()][lines.get(0).length()];
        for (int i = 0; i < fields.length; i++) {
            String row = lines.get(i);
            char[] chars = row.toCharArray();
            fields[i] = chars;

            for (int y = 0; y < chars.length; y++) {
                if (fields[i][y] == 'S') {
                    start = new Coord(i, y);
                }
            }
        }

        List<Path> openPaths = new ArrayList<>();

    }

    private static boolean isValidPoint(char[][] fields, Coord coord) {
        return coord.x > 0 && coord.y > 0 && coord.y < fields.length && coord.x < fields[coord.y].length;
    }

    private static class Path {

        private LinkedList<Coord> fields;

        public Path(Coord start) {
            this.fields = new LinkedList<>();
            this.fields.add(start);
        }

    }

    private static class Coord {

        public int x, y;

        public Coord(int x, int y) {
            this.x = x;
            this.y = y;
        }

    }
}
