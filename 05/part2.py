from datetime import datetime
import re

maps = {}
seeds = []
last_source = ""

with open('input.txt') as f:
    for line in f:
        if (line.startswith("seeds: ")):
            seedsString = (line[len("seeds: ") : len(line)]);
            seedsStringValues = seedsString.split(" ")
            seeds = [int(x) for x in seedsStringValues]
            continue;
        
        line = line.replace('\n', '').replace('\r', '')
        if (line.endswith(":") == True):
            regexp_1 = re.compile(r'^([a-zA-Z]+)-to-([a-zA-Z]+)\smap:$')
            groups = regexp_1.match(line).groups();
            source = groups[0];
            destination = groups[1];
            if not (source in maps):
                maps[source] = {}
            maps[source]["target"] = destination;
            maps[source]["values"] = []
            last_source = source
        else:
            splits = line.split(" ")
            if (len(splits) == 1):
                continue
            dest_start = int(splits[0])
            source_start = int(splits[1])
            ra = int(splits[2])
            maps[last_source]["values"].append([dest_start, source_start, ra])

    minLocation = 9999999999

    sdasd = (int) (len(seeds) / 2)
    for si in range(sdasd):
        seedStart = seeds[si * 2]
        print("Working on " + str(si) + "/" + str(sdasd))
        now = datetime.now()
        for dsi in range(seeds[si * 2 + 1]):
            if (dsi % 1_000_000 == 0):
                new_now = datetime.now()
                print("Sub " + str(dsi) + "/" + str(seeds[si * 2 + 1]) + " " + str(dsi / seeds[si * 2 + 1] * 100)[0:5] + "% in " + str(new_now - now) + "ms")
                now = new_now
            currentIndex = seedStart + dsi
            currentSource = "seed"
            while currentSource != "location":
                for vr in maps[currentSource]["values"]:
                    if currentIndex >= vr[1] and currentIndex <= vr[1] + vr[2]:
                        currentIndex = vr[0] + (currentIndex - vr[1])
                        break
                # if currentIndex in maps[currentSource]["values"]:
                #     currentIndex = maps[currentSource]["values"][currentIndex]
                currentSource = maps[currentSource]["target"]
            # print(str(seed) + " goes to " + str(currentIndex) + " in " + currentSource)
            if currentIndex < minLocation:
                minLocation = currentIndex

    print("Min location: " + str(minLocation))