#!/usr/bin/env node
const app = require("express")();
const bodyParser = require("body-parser");
const { dir } = require("console");
const fs = require("fs");
var os = require("os");

const port = 10043;

app.use(bodyParser.json());

const plat = os.platform();

const createDir = (dirPath) => {
  fs.mkdirSync(dirPath, { recursive: true }, (error) => {
    if (error) console.log("An error occured while creating directory");
    else console.log("Directory created!");
  });
};

const createFile = (filePath, fileContent, programName) => {
  fs.writeFile(filePath, fileContent, (error) => {
    if (error) console.log("An error occured while creating test cases");
    else console.log(`Files created for ${programName}`);
  });
};

app.post("/", (req, res) => {
  const data = req.body;
  var path = "",
    filePath = "";
  if (plat === "linux") {
    path = process.cwd() + "/" + data.name;
    filePath = process.cwd() + "/" + data.name + `/`;
  } else {
    path = process.cwd() + "\\" + data.name;
    filePath = process.cwd() + "\\" + data.name + `\\`;
  }
  createDir(path);
  const len = data.tests.length;
  for (var i = 0; i < len; ++i) {
    var testCases = data["tests"][i]["input"];
    var output = data["tests"][i]["output"];
    createFile(`${filePath}in${i}`, testCases, data.name);
    createFile(`${filePath}out${i}`, output, data.name);
  }
  res.sendStatus(200);
});

app.listen(port, (err) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
});
