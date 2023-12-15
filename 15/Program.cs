Func<String, long> toAlgorithm = (line) => {
    long total = 0;

    char[] characters = line.ToCharArray();
    for (int i = 0; i < characters.Length; i++) {
        int v = characters[i];

        total += v;
        total *= 17;
        total %= 256;
    }

    return total;
};

String line;
List<Lense>[] boxes = new List<Lense>[256];
try
{
    StreamReader sr = new StreamReader("input.txt");
    while ((line = sr.ReadLine()) != null)
    {
        line += ",";
        String[] cmds = line.Split(",");
        foreach (String cmd in cmds) {
            if (cmd.Length == 0) continue;
            if (cmd.IndexOf('-') >= 0) {
                String lenseLabel = cmd.Substring(0, cmd.Length - 1);
                long boxIndex = toAlgorithm(lenseLabel);
                List<Lense> box = boxes[boxIndex];
                if (box != null) {
                    int lenseIndex = box.FindIndex(lense => lense.label == lenseLabel);
                    
                    // Console.WriteLine("- for \"" + lenseLabel + "\" found at index: " + lenseIndex + " in " + boxIndex);
                    // Console.WriteLine("Box info: |" + box.Count + "| @-1: " + box[box.Count - 1]);

                    if (lenseIndex >= 0) {
                        for (int i = lenseIndex; i < box.Count - 1; i++) {
                            box[i] = box[i + 1];
                        }
                        if (box[box.Count - 1] != null) box.Remove(box[box.Count - 1]);
                        boxes[boxIndex] = box;
                    }
                }
            } else {
                String lenseLabel = cmd.Split('=')[0];
                long boxIndex = toAlgorithm(lenseLabel);
                List<Lense> box = boxes[boxIndex];
                if (box == null) {
                    box = new List<Lense>();
                    boxes[boxIndex] = box;
                }

                String powerString = cmd.Split('=')[1];
                long power = long.Parse(powerString);

                int lenseIndex = box.FindIndex(lense => lense.label == lenseLabel);
                if (lenseIndex >= 0) {
                    box[lenseIndex] = new Lense(lenseLabel, power);
                } else {
                    box.Add(new Lense(lenseLabel, power));
                }
            }

            // printing current state:
            // Console.WriteLine();
            // for (int q = 0;  q < boxes.Length; q++) {
            //     List<Lense> box = boxes[q];
            //     if (box != null) {
            //         Console.Write("Box " + q + ": ");

            //         foreach (Lense lense in box) {
            //             Console.Write("[" + lense.label + " " + lense.power + "] ");
            //         }
            //         Console.WriteLine();
            //     }
            // }
        }
    }
    sr.Close();

    long total = 0;
    for (int i = 0; i < boxes.Length; i++) {
        if (boxes[i] == null) continue;

        List<Lense> box = boxes[i];
        for (int j = 0; j < box.Count; j++) {
            total += (1 + i) * (1 + j) * box[j].power;
        }
    }

    Console.WriteLine("Total: " + total);
}
catch(Exception e)
{
    Console.WriteLine("Exception: " + e.Message);
}

public record Lense(string label, long power);

// Part 1:
/*
String line;
try
{
    long total = 0;
    long subTotal = 0;
    StreamReader sr = new StreamReader("input.txt");
    while ((line = sr.ReadLine()) != null)
    {
        char[] characters = line.ToCharArray();
        for (int i = 0; i < characters.Length; i++) {
            int v = characters[i];

            if (v == (int) ',') {
                total += subTotal;
                subTotal = 0;
                continue;
            }

            subTotal += v;
            subTotal *= 17;
            subTotal %= 256;
        }
    }

    total += subTotal;
    subTotal = 0;

    sr.Close();

    Console.WriteLine("Total: " + total);
}
catch(Exception e)
{
    Console.WriteLine("Exception: " + e.Message);
}
*/