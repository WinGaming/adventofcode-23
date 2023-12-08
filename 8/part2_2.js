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

console.log(currentNodes);

const isDone = () => currentNodes.find(node => node[node.length - 1] !== "Z") === undefined;

let currentStep = 0;
while (!isDone()) {
    for (let i = 0; i < currentNodes.length; i++) {
        const letter = direction[currentStep % direction.length];
        currentNodes[i] = directions[currentNodes[i]][letter === "L" ? 0 : 1];
    }

    if (currentStep % 100_000_000 === 0) console.log(currentStep, currentStep / 12_030_780_859_469 * 100);
    currentStep++;
}

console.log("Done in " + currentStep + " steps");