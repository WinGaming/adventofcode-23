import java.util.Arrays;

class Path {

    private final Coord[] fields;

    public Path(Coord...coords) {
        this.fields = coords;
    }

    public Path cloneWith(Coord coord) {
        Coord[] newArray = new Coord[this.fields.length + 1];
        System.arraycopy(this.fields, 0, newArray, 0, this.fields.length);
        newArray[newArray.length - 1] = coord;
        return new Path(newArray);
    }

    public int getLength() {
        return this.fields.length;
    }

    public Coord getLastElement() {
        return fields[fields.length - 1];
    }

    public boolean containsCoordIgnoreReverse(Coord coord) {
        if (this.fields.length > 3 && this.fields[0].equals(coord)) return false;
        // if (this.fields.length <= 2 && this.fields.length > 0 && this.fields[0].equals(coord)) return true;
        // if (this.fields.length >= 2 && this.fields[this.fields.length - 2].equals(coord)) return true;

        for (Coord field : this.fields) {
            if (field.equals(coord)) return true;
        }

        return false;
    }

    @Override
    public String toString() {
        return Arrays.toString(fields);
    }

}
