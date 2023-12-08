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

let currentNode = "AAA";
let counter = 0;
for (let i = 0; true; i++) {
    counter++;
    currentNode = directions[currentNode][direction[i % direction.length] === "L" ? 0 : 1];
    if (currentNode === "ZZZ") break;
}

console.log(currentNode, content, counter);