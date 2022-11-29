import { readFile, formatInputAsNumbers } from "../../js-helpers.js";
const DAY = process.env["DAY"]
const inputFilePath = `./2021/day${DAY}/input.txt`

// take in an array of numbers representing depth readings
// return the number of times the depth increases
function countNumberOfIncreases(depthReport) {
  let counter = 0;
  depthReport.forEach((depthReading, index) => {
    if (index === 0) {
      // console.log("starting!");
    } else if (depthReading > depthReport[index - 1]) {
      // console.log(`${depthReading} is greater than ${depthReport[index-1]}`);
      counter++;
    } else {
      // console.log(`${depthReading} is NOT greater than ${depthReport[index-1]}`);
    }
  });
  return counter;
}

function solve() {
  const input = readFile(inputFilePath);
  const depthReport = formatInputAsNumbers(input);
  const answer = countNumberOfIncreases(depthReport);
  console.log(answer);
}

solve();