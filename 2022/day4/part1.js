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
//      [2,4,6,7,8],
//      [2,3,4,5]
//     ]
function formatInputAsRanges(input) {
  const inputArray = formatInputAsLineStringsArray(input)
  return inputArray.map((line) => line.split(/,|-/).map((numStr) => Number(numStr)))
}

// A full overlap occurs when:
// the lower bound of one range is greater than the lower of the other
//  & the upper bound of the initial range is lower than that of the other
function countFullOverlaps(ranges) {
  let fullyContainedSectionsCounter = 0;
  ranges.forEach((rangePair) => {
    if (rangePair[0] >= rangePair[2] && rangePair[1] <= rangePair[3]) {
      fullyContainedSectionsCounter += 1;
    } else if (rangePair[2] >= rangePair[0] && rangePair[3] <= rangePair[1]) {
      fullyContainedSectionsCounter += 1;
    }
  })
  return fullyContainedSectionsCounter;
}
// Convert inputs to array or string of section ids
// Check if one set of sections is fully overlapping with the other (how?)
// increment a counter representing the number of full overlaps
function solve() {
  console.log(`Solving year ${YEAR} day ${DAY} part ${PART}`)
  const input = readFile(inputFilePath);
  const ranges = formatInputAsRanges(input);
  const answer = countFullOverlaps(ranges)
  console.log(answer);
}

solve();