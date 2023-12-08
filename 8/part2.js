const {readFileSync} = require("fs");
const {resolve} = require("path");

const content = readFileSync(resolve("input.txt")).toString();

const lines = content.split("\n");
const direction = lines[0].replace(/\r|\n/, "");

const directions = {};
for (let i = 2; i < lines.length; i++) {
    const parts = lines[i].split(" ");
    directions[parts[0]] = parts.filter((_, i) => i >= 2).map(part => part.replace(/\(|\)/, "").replace(/\r|\n/, "").replace(/,/, ""));
}


let currentNodes = Object.keys(directions).filter(key => key[key.length - 1] === "A");
let counter = 0;
for (let i = 0; true; i++) {
    counter++;
    currentNodes = currentNodes.map(node => {
        return directions[node][direction[i % direction.length] === "L" ? 0 : 1];
    })
    let test = true;
    for (let j = 0; j < currentNodes.length; j++) {
        if (currentNodes[j].length !== 3) throw "whwhwhwhw!?!?!?";
        if (currentNodes[j][2] !== "Z") test = false;
    }
    if (test) break;
    if (currentNodes.reduce((val, node) => val && node[node.length - 1] === "Z", true)) break;
}

console.log(currentNodes, content, counter);