import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class Part1 {

    private static Field[][] fields;
    private static Optional<Path> theGreatLoop = Optional.empty();

    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new FileReader(new File("input.txt")));
        String line;
        List<String> lines = new ArrayList<>();
        while ((line = reader.readLine()) != null) {
            lines.add(line);
        }
        reader.close();

        Coord start = null;
        fields = new Field[lines.size()][lines.get(0).length()];
        for (int i = 0; i < fields.length; i++) {
            String row = lines.get(i);
            char[] chars = row.toCharArray();
            fields[i] = parseFields(chars);

            for (int x = 0; x < chars.length; x++) {
                if (fields[i][x] == Field.START) {
                    start = new Coord(x, i);
                }
            }
        }

        if (start == null) throw new IllegalStateException("Maze does not contain a start");

        List<Path> openPaths = new ArrayList<>();
        openPaths.add(new Path(start));

        while (openPaths.size() > 0 && theGreatLoop.isEmpty()) {
            openPaths = doStep(openPaths);

//            System.out.println("=================");
//            openPaths.forEach(System.out::println);
        }

        if (theGreatLoop.isPresent()) {
            Path loop = theGreatLoop.get();
            System.out.println(loop);
            System.out.println("Max distance in steps: " + loop.getLength() / 2d);
        } else {
            throw new IllegalStateException("No great loop found!");
        }

        // System.out.println("-------------");
        // openPaths.forEach(System.out::println);
    }

    private static List<Path> doStep(List<Path> openPaths) {
        List<Path> newPaths = new ArrayList<>();
        for (Path path : openPaths) {
            List<Path> result = doStep(path);
            newPaths.addAll(result);
            if (theGreatLoop.isPresent()) return result;
        }

        return newPaths;
    }

    private static List<Path> doStep(Path path) {
        List<Path> result = new ArrayList<>();
        Coord currentField = path.getLastElement();

        for (Direction direction : Direction.values()) {
            Coord target = currentField.relative(direction);
            if (path.containsCoordIgnoreReverse(target)) continue; // Detected loop

            if (getField(fields, target) == Field.START && connectedFrom(currentField, direction)) {
                theGreatLoop = Optional.of(path.cloneWith(currentField.relative(direction)));
                return List.of(theGreatLoop.get());
            }

            // System.out.println("Do step for " + path + " with " + direction + " (" + target + "): " + connectedFrom(currentField, direction));

            if (connectedFrom(currentField, direction)) {
                result.add(path.cloneWith(target));
            }
        }

        return result;
    }
    
    private static boolean connectedFrom(Coord start, Direction direction) {
        Coord target = start.relative(direction);
        return isValidPoint(fields, target) && getField(fields, start).connectsTo(direction) && getField(fields, target).connectsTo(direction.getOpposite());
    }

    private static Field getField(Field[][] fields, Coord coord) {
        if (!isValidPoint(fields, coord)) return null;
        return fields[coord.y][coord.x];
    }

    private static Field[] parseFields(char[] fields) {
        Field[] parsed = new Field[fields.length];
        for (int i = 0; i < fields.length; i++) {
            parsed[i] = Field.getFieldByIcon(fields[i]);
        }

        return parsed;
    }

    private static boolean isValidPoint(Field[][] fields, Coord coord) {
        return coord.x >= 0 && coord.y >= 0 && coord.y < fields.length && coord.x < fields[coord.y].length;
    }


}
