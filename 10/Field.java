public enum Field {
    VERTICAL('|', Direction.UP, Direction.DOWN),
    HORIZONTAL('-', Direction.LEFT, Direction.RIGHT),
    NORTH_EAST('L', Direction.UP, Direction.RIGHT),
    NORTH_WEST('J', Direction.UP, Direction.LEFT),
    SOUTH_WEST('7', Direction.DOWN, Direction.LEFT),
    SOUTH_EAST('F', Direction.DOWN, Direction.RIGHT),
    EMPTY('.'),
    START('S', Direction.values());

    private final char icon;
    private final Direction[] connections;

    Field(char icon, Direction...directions) {
        this.icon = icon;
        this.connections = directions;
    }

    public char getIcon() {
        return icon;
    }

    public boolean connectsTo(Direction direction) {
        for (Direction dir : this.connections) {
            if (dir == direction) return true;
        }

        return false;
    }

    public static Field getFieldByIcon(char icon) {
        for (Field field : values()) {
            if (field.getIcon() == icon) return field;
        }

        return null;
    }
}