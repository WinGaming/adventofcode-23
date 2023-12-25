const { resolve } = require("path");
const { readFileSync } = require("fs");

let maps = {}
let seeds = []
let last_source = ""

const lines = readFileSync(resolve("input.txt")).toString().split("\r\n");
// with open('input.txt') as f:
    for (let line of lines) {
        if (line.startsWith("seeds: ")) {
            let seedsString = line.substring("seeds: ".length);
            let seedsStringValues = seedsString.split(" ")
            seeds = seedsStringValues.map(e => parseInt(e));
            continue;
        }

        line = line.replace('\n', '').replace('\r', '')
        if (line.endsWith(":")) {
            let regexp_1 = (/^([a-zA-Z]+)-to-([a-zA-Z]+)\smap:$/)
            let match = line.match(regexp_1);
            source = match[1];
            destination = match[2];
            console.log(source + " -> " + destination);
            if (!(source in maps)) {
                maps[source] = {}
            }
            maps[source]["target"] = destination;
            maps[source]["values"] = []
            last_source = source
        } else {
            let splits = line.split(" ")
            if (splits.length == 1) continue;
            let dest_start = (splits[0])
            let source_start = (splits[1])
            let ra = (splits[2])
            maps[last_source]["values"].push([dest_start, source_start, ra])
        }
    }
    
    let minLocation = 9999999999

    let sdasd = ((seeds.length) / 2)
    for (let si = 0; si < sdasd; si++) {
        let seedStart = seeds[si * 2]
        console.log("Working on " + si + "/" + sdasd)
        let now = Date.now();
        for (let dsi = 0; dsi < seeds[si * 2 + 1]; dsi++) {
            if (dsi % 1_000_000 == 0) {
                let new_now = Date.now()
                console.log("Sub " + dsi + "/" + seeds[si * 2 + 1] + " " + ((dsi / seeds[si * 2 + 1] * 100) + "").substring(0, 5) + "% in " + (new_now - now) + "ms")
                now = new_now
            }
            let currentIndex = seedStart + dsi
            currentSource = "seed"
            while (currentSource != "location") {
                for (vr in maps[currentSource]["values"]) {
                    if (currentIndex >= vr[1] && currentIndex <= vr[1] + vr[2]) {
                        currentIndex = vr[0] + (currentIndex - vr[1])
                        break
                    }
                }
                // if currentIndex in maps[currentSource]["values"]:
                //     currentIndex = maps[currentSource]["values"][currentIndex]
                currentSource = maps[currentSource]["target"]
            }
            // print(str(seed) + " goes to " + str(currentIndex) + " in " + currentSource)
            if (currentIndex < minLocation) {
                minLocation = currentIndex
            }
        }
    }
    print("Min location: " + str(minLocation))