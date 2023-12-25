line_regex = r"^Game\s([0-9]*):\s([0-9a-z\s,;]*)$";

restrictions = Dict(
    "red" => 12,
    "green" => 13,
    "blue" => 14,
);

total = 0
open("input.txt") do f
    while ! eof(f) 
        s = readline(f)		 

        m = match(line_regex, s);
        gameId = parse(Int, m[1]);
        gameText = m[2];
        parts = split(gameText, ";");

        for draw in parts
            elements = split(draw, ",");
            for draw_group in elements
                striped = strip(draw_group)
                split_striped = split(striped, " ");
                count = parse(Int, split_striped[1])
                color = split_striped[2]
                if count > restrictions[color]
                    @goto invalid_game
                end
            end
        end

        global total += gameId

        @label invalid_game
    end
end

println("$total")
