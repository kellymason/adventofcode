import { readFile, formatInputAsNumbers } from "../../js-helpers.js";
const YEAR = process.env["YEAR"]
const DAY = process.env["DAY"]
const PART = process.env["PART"]
const inputFilePath = `./${YEAR}/day${DAY}/input.txt`

// Takes in an array of numbers (with 0 representing a space between elves)
// Returns the total number of calories carried by the swollest elf.
function findSwollestElfCalorieTotal (input) {
  let swollElfCalorieCounter = 0;
  let currentElfCalorieCounter = 0;
  input.forEach(line => {
    currentElfCalorieCounter += line
    // if we get to the end of an elf's calorie list,
    // check if their total is greater than swollElfCalorieCounter
    if (line === 0) {
      if (currentElfCalorieCounter > swollElfCalorieCounter) {
        swollElfCalorieCounter = currentElfCalorieCounter;
      }
      currentElfCalorieCounter = 0;
    }
  });
  return swollElfCalorieCounter;
}

function solve() {
  console.log(`Solving year ${YEAR} day ${DAY} part ${PART}`)
  const input = readFile(inputFilePath);
  const elfCaloriesList = formatInputAsNumbers(input);
  // console.log(`Calories list: ${elfCaloriesList}`);
  const answer = findSwollestElfCalorieTotal(elfCaloriesList);
  console.log(answer);
}

solve();