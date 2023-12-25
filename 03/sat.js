const { readFileSync } = require("fs");
const { resolve } = require("path");

const lines = readFileSync(resolve("input.txt")).toString().split("\r\n");

let total = 0;
for (let y = 0; y < 140; y++) {
    let parsed = 0;
    let startX = -1;
    for (let x = 0; x < 140; x++) {
        let c = lines[y][x];
        if (c >= '0' && c <= '9') {
            if (parsed <= 0) startX = x;
            parsed *= 10;
            parsed += (c - '0');
        } else {
            if (parsed > 0) {
                console.log(parsed);
                a:
                for (let dy = Math.max(0, y - 1); dy <= Math.min(y + 1, lines.length - 1); dy++) {
                    for (let dx = Math.max(0, startX - 1); dx <= Math.min(x + 1, lines[y].length - 1); dx++) {
                        let m = lines[dy][dx];
                        if ((m < '0' || m > '9') && m != '.') {
                            total += parsed;
                            continue a;
                        }
                    }
                }
            }

            parsed = 0;
        }
    }
}

console.log(total);