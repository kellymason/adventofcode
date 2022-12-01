import { readFile, formatInputAsNumbers } from "../../js-helpers.js";
const YEAR = process.env["YEAR"]
const DAY = process.env["DAY"]
const PART = process.env["PART"]
const inputFilePath = `./${YEAR}/day${DAY}/input.txt`

// Takes in an array of numbers (with 0 representing a space between elves)
// Returns the total number of calories carried by the swollest 3 elves.
function findSwollestElvesCalorieTotal (input) {
  const lastInputIndex = input.length - 1;
  let swollElvesCalorieCounter = [0, 0, 0];
  let currentElfCalorieCounter = 0;
  input.forEach(line => {
    currentElfCalorieCounter += line;
    // if we get to the end of an elf's calorie list,
    // check if their total is greater than swollElfCalorieCounter
    if (line === 0 || input.indexOf(line) == lastInputIndex) {
      const lowestSwollCalorieAmount = Math.min(...swollElvesCalorieCounter)
      if (currentElfCalorieCounter > lowestSwollCalorieAmount) {
        swollElvesCalorieCounter.push(currentElfCalorieCounter);
        const lowestCalsIndex = swollElvesCalorieCounter.indexOf(lowestSwollCalorieAmount)
        swollElvesCalorieCounter.splice(lowestCalsIndex, 1);
      }
      currentElfCalorieCounter = 0;
    }
  });
  return swollElvesCalorieCounter;
}

function totalCaloriesCarriedBySwollElves (calorieArray) {
  return calorieArray.reduce((a,b) => a + b)
}

function solve() {
  console.log(`Solving year ${YEAR} day ${DAY} part ${PART}`)
  const input = readFile(inputFilePath);
  const elfCaloriesList = formatInputAsNumbers(input);
  const calorieArray = findSwollestElvesCalorieTotal(elfCaloriesList);
  const answer = totalCaloriesCarriedBySwollElves(calorieArray);
  console.log(answer);
}

solve();