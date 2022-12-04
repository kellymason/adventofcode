import { readFile, formatInputAsLineStringsArray } from "../../js-helpers.js";
const YEAR = process.env["YEAR"]
const DAY = process.env["DAY"]
const PART = process.env["PART"]
const inputFilePath = `./${YEAR}/day${DAY}/input.txt`

// takes in input and converts it to an array of tuples representing pairs of ranges
// in: [
// ' 2-4,6-8',
//  '2-3,4-5'
// ]
// out: [
//      [2,4,6,8],
//      [2,3,4,5]
//     ]
function formatInputAsRanges(input) {
  const inputArray = formatInputAsLineStringsArray(input)
  return inputArray.map((line) => line.split(/,|-/).map((numStr) => parseInt(numStr)))
}

// Takes in an array of arrays, each containing 4 integers representing the range pairs
// counts how many subarrays countain range pairs that overlap
function countOverlaps(rangeArrays) {
  let overlapCounter = 0;
  rangeArrays.forEach((rangePairArray) => {
    // if the first lower bound is lower than or equal to the second
    // and the first upper bound is higher or equal to the second lower bound
    if (rangePairArray[0] <= rangePairArray[2] && rangePairArray[1] >= rangePairArray[2]) {
      overlapCounter += 1
    } else if (rangePairArray[0] >= rangePairArray[2] && rangePairArray[3] >= rangePairArray[0]) {
      overlapCounter += 1
    }
  })
  return overlapCounter;
}
// Convert inputs to array or string of section ids
// Check if one set of sections is fully overlapping with the other (how?)
// increment a counter representing the number of full overlaps
function solve() {
  console.log(`Solving year ${YEAR} day ${DAY} part ${PART}`)

  const input = readFile(inputFilePath);
  const ranges = formatInputAsRanges(input);
  const answer = countOverlaps(ranges);
  console.log(answer);
}

solve();