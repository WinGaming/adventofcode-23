import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class Part2 {

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

            BufferedImage image = new BufferedImage(fields[0].length * 3, fields.length * 3, BufferedImage.TYPE_INT_RGB);
           /* for (int y = 0; y < fields.length; y++) {
                for (int x = 0; x < fields[y].length; x++) {
                    if (loop.contains(new Coord(x, y))) image.setRGB(x * 3, y * 3, new Color(0, 100, 0).getRGB());
                }
            }*/

            for (int i = 0; i < loop.getLength(); i++) {
                Coord currentCoord = loop.getFields()[i];
                image.setRGB(currentCoord.x * 3 + 1, currentCoord.y * 3 + 1, new Color(0, 100, 0).getRGB());

                if (i > 0) {
                    Coord prevCoord = loop.getFields()[i - 1];
                    for (int x = Math.min(prevCoord.x, currentCoord.x) * 3; x <= Math.max(prevCoord.x, currentCoord.x) * 3; x++) {
                        for (int y = Math.min(prevCoord.y, currentCoord.y) * 3; y <= Math.max(prevCoord.y, currentCoord.y) * 3; y++) {
                            image.setRGB(x + 1, y + 1, new Color(0, 100, 0).getRGB());
                        }
                    }
                }
            }

            List<Coord> infected = new ArrayList<>();
            List<Coord> spreader = new ArrayList<>();

            spreader.add(new Coord(0, 0)); // it will work for the task, trust my bro!
            image.setRGB(0, 0, new Color(0, 0, 100).getRGB());

            while (!spreader.isEmpty()) {
                List<Coord> newSpreaders = new ArrayList<>();
                for (Coord coord : spreader) {
                    for (Direction direction : Direction.values()) {
                        Coord newCoord = coord.relative(direction);

                        if (newCoord.x < 0 || newCoord.y < 0) continue;
                        if (newCoord.x >= image.getWidth() || newCoord.y >= image.getHeight()) continue;
                        if (image.getRGB(newCoord.x, newCoord.y) == new Color(0, 100, 0).getRGB()) continue;
                        if (infected.contains(newCoord)) continue;
                        if (spreader.contains(newCoord)) continue;
                        if (newSpreaders.contains(newCoord)) continue;

                        image.setRGB(newCoord.x, newCoord.y, new Color(0, 0, 100).getRGB());

                        newSpreaders.add(newCoord);
                    }
                }

                infected.addAll(spreader);
                spreader = newSpreaders;
            }

           /* for (Coord coord : infected) {
                if (coord.y == -1 || coord.x == -1 || coord.x == image.getWidth() || coord.y == image.getHeight()) continue;
                image.setRGB(coord.x, coord.y, new Color(0, 0, 100).getRGB());
            }*/

            ImageIO.write(image, "png", new File("out.png"));

            int counter = 0;
            for (int y = 0; y < fields.length; y++) {
                for (int x = 0; x < fields[0].length; x++) {
                    if (image.getRGB(x * 3 + 1, y * 3 + 1) == Color.black.getRGB()) counter++;
                }
            }

            System.out.println("Enclosed spaces: " + counter);
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
