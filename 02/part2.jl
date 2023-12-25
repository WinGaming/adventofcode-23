line_regex = r"^Game\s([0-9]*):\s([0-9a-z\s,;]*)$";

total = 0
open("input.txt") do f
    while ! eof(f) 
        s = readline(f)		 

        m = match(line_regex, s);
        gameId = parse(Int, m[1]);
        gameText = m[2];
        parts = split(gameText, ";");

        minimal_dict = Dict();

        for draw in parts
            elements = split(draw, ",");
            for draw_group in elements
                striped = strip(draw_group)
                split_striped = split(striped, " ");
                count = parse(Int, split_striped[1])
                color = split_striped[2]
                if haskey(minimal_dict, color)
                    minimal_dict[color] = max(minimal_dict[color], count)
                else
                    minimal_dict[color] = count
                end
            end
        end

        power = 1
        for (color, min_count) in minimal_dict
            power *= min_count
        end

        global total += power
    end
end

println("$total")
