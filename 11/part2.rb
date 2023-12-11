class Coord
    attr_accessor :x, :y

    def initialize(x, y)
        @x = x
        @y = y
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
    if !line.match /#/
        new_line = ""
        line.length.times do |m|
            new_line += "="
        end
        lines.push new_line
    else
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
        lines[y] = lines[y][0..index - 1] + "=" + lines[y][index + 1..lines[y].length]
    end
end

puts "Expanded: "
puts lines
puts "\n"

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
        # total += a.distance b
        # def distance(other)
        #     (other.x - self.x).abs + (other.y - self.y).abs
        # end
        min_x = [a.x, b.x].min
        max_x = [a.x, b.x].max

        min_y = [a.y, b.y].min
        max_y = [a.y, b.y].max

        total += (max_x - min_x) + (max_y - min_y)

        expander_counter = 0
        # Count column expanders
        additional_columns.each do |expand_col_index|
            if expand_col_index > min_x && expand_col_index < max_x
                expander_counter += 1
            end
        end

        # Count row expanders
        for y in min_y..max_y
            if lines[y][0] == '='
                expander_counter += 1
            end
        end

        total += expander_counter * (1000000 - 1)
        # puts a.to_s + " -> " + b.to_s + " => " + expander_counter.to_s
    end
end

total /= 2 # We check add every pair from both sides, so we need to devide the value by 2

puts total