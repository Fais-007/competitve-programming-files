// @node @node "path\index.js" %*

const app = require("express")();
const bodyParser = require("body-parser");
const fs = require("fs");

const port = 10043;

app.use(bodyParser.json());

var dir = process.cwd();

const createDir = (dirPath) => {
  fs.mkdirSync(process.cwd() + "\\" + dirPath, { recursive: true }, (error) => {
    if (error) console.log("An error occured while creating directory");
    else console.log("Directory created!");
  });
};

const createFile = (filePath, fileContent) => {
  fs.writeFile(filePath, fileContent, (error) => {
    if (error) console.log("An error occured while creating test cases");
    else console.log("Files created");
  });
};

app.post("/", (req, res) => {
  const data = req.body;
  createDir(data.name);
  const len = data.tests.length;
  for (var i = 0; i < len; ++i) {
    var testCases = data["tests"][i]["input"];
    var output = data["tests"][i]["output"];
    createFile(process.cwd() + "\\" + data.name + `\\in${i}`, testCases);
    createFile(process.cwd() + "\\" + data.name + `\\out${i}`, output);
  }
  res.sendStatus(200);
});

app.listen(port, (err) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
});
