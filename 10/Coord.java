import java.util.Objects;

class Coord {

    public int x, y;

    public Coord(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public Coord relative(Direction direction) {
        return new Coord(
                this.x + (direction == Direction.LEFT ? -1 : (direction == Direction.RIGHT ? 1 : 0)),
                this.y + (direction == Direction.UP ? -1 : (direction == Direction.DOWN ? 1 : 0))
        );
    }

    @Override
    public String toString() {
        return "Coord{" +
                "x=" + x +
                ", y=" + y +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Coord coord = (Coord) o;
        return x == coord.x && y == coord.y;
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y);
    }
}
