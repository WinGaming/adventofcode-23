class Coord
    attr_accessor :x, :y

    def initialize(x, y)
        @x = x
        @y = y
    end

    def distance(other)
        (other.x - self.x).abs + (other.y - self.y).abs
    end

    def to_s
        "Coord{x= #{@x}, y= #{@y}}"
    end
end

input_data = File.read "input.txt"
lines = input_data.split

puts "Original: "
puts lines
puts "\n"

# Expanding rows
lines_copy = lines.clone
lines = []

lines_copy.clone.each do |line|
    lines.push line
    
    if (!line.match /#/)
        lines.push line
    end
end

# Expanding columns
additional_columns = []
lines[0].length.times do |x|
    empty_line = true
    for y in 0..lines.length - 1
        if lines[y][x] == '#'
            empty_line = false
        end
    end

    if empty_line
        additional_columns.push x
    end
end

additional_columns.reverse.each do |index|
    lines.length.times do |y|
        lines[y] = lines[y][0..index] + lines[y][index..lines[y].length]
    end
end

# Determine the positions of all galaxy
galaxies = []
lines.length.times do |y|
    lines[y].length.times do |x|
        if lines[y][x] == '#'
            galaxies.push Coord.new(x, y)
        end
    end
end

# Calculate total distance
total = 0
galaxies.each do |a|
    galaxies.each do |b|
        # The distance between two times the same galaxy is 0, so we don't need to care about that edge-case
        total += a.distance b
    end
end

total /= 2 # We check add every pair from both sides, so we need to devide the value by 2

puts total