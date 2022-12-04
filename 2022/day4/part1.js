import { readFile, formatInputAsLineStringsArray } from "../../js-helpers.js";
const YEAR = process.env["YEAR"]
const DAY = process.env["DAY"]
const PART = process.env["PART"]
const inputFilePath = `./${YEAR}/day${DAY}/input.txt`
const WRONG_ANSWERS = [796] //too high
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
  return inputArray.map((line) => line.split(/,|-/).map((numStr) => parseInt(numStr)))
}

  // Take in an array of subarrays containing the bounds of each pair of ranges
  // Return an array that holds tuples representing pairs of arrays of section ids
  // in: [ [2,4,6,8], [2,3,4,5]]
  // out: [
  //       [[2,3,4], [6,7,8]],
  //       [[2,3], [4,5]]
  // ]
function sectionIdsFromRanges (rangesArray) {
  const newArray = []
  rangesArray.forEach((arrayOfRanges) => {
    newArray.push(
    [
      Array(Math.ceil((arrayOfRanges[1] + 1) - arrayOfRanges[0])).fill(arrayOfRanges[0]).map((x, y) => x + y ), 
      Array(Math.ceil((arrayOfRanges[3] + 1) - arrayOfRanges[2])).fill(arrayOfRanges[2]).map((x, y) => x + y )
    ]
    )
  })
  // console.log(newArray[0])
  return newArray
}

// Takes in an array of tuples that hold arrays representing section assignment ids
// Returns a count of the section assignment id pairs where one is fully contained in the other
function countFullOverlaps(sectionIds) {
  let fullyContainedSectionsCounter = 0;
  sectionIds.forEach((sectionIDPair) => {
    const firstLength = sectionIDPair[0].length
    const secondLength = sectionIDPair[1].length
    const shorterSectionRange = firstLength < secondLength ? sectionIDPair[0] : sectionIDPair[1]
    const longerSectionRange = firstLength < secondLength ? sectionIDPair[1] : sectionIDPair[0]
    // check whether every item in the shorter section is contained in the longer one
    if (shorterSectionRange.every((item) => longerSectionRange.includes(item))) { fullyContainedSectionsCounter += 1}
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
  const arrayOfSectionIdTuples = sectionIdsFromRanges(ranges)
  const answer = countFullOverlaps(arrayOfSectionIdTuples);
  console.log(answer);
}

solve();