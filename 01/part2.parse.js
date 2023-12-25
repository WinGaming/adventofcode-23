const { resolve } = require("path");
const { readFileSync, writeFileSync } = require("fs");

const outfile = resolve("part2.sql");
const lines = readFileSync(resolve("input.txt")).toString().split("\r\n");

const templateContent = readFileSync(resolve("part2.template.sql")).toString();

writeFileSync(outfile, (() => {
    let builder = "";
    lines.forEach((line, i) => {
        builder += `INSERT INTO input VALUES (${i}, "${line}");\n`;
    })
    builder = builder.substring(0, builder.length - 1);
    return templateContent.replace("%%DATA%%", builder);
})());

