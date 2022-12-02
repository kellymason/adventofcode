import { readFile, formatInputAsArrayOfTupleChars } from "../../js-helpers.js";
const YEAR = process.env["YEAR"]
const DAY = process.env["DAY"]
const PART = process.env["PART"]
const inputFilePath = `./${YEAR}/day${DAY}/input.txt`

// X lose, Y draw, Z win

const WRONG_ANSWERS = [8293, 12297]

// each round, check what I threw and if I won (compare ABC to XYZ)
// and add to my score
function myTotalScore (roundInfo) {
  let myScore = 0;
  roundInfo.forEach(round => {
    // opponent throws rock
    if (round[0] === 'A') {
      if (round[1] === 'X') {
        // 0 for loss, 3 for scissors
        myScore += 3
      } else if (round[1] === 'Y') {
        // 3 for draw, 1 for rock
        myScore += 4
      } else {
        // 6 for win, 2 for paper
        myScore += 8
      }
    } // opponent throws paper
    else if (round[0] === 'B') {
      if (round[1] === 'X') {
        // 0 for loss, 1 for rock
        myScore += 1
      } else if (round[1] === 'Y') {
        // 3 for draw, 2 for paper
        myScore += 5
      } else {
        // 6 for win, 3 for scissors
        myScore += 9
      }
    } // opponent throws scissors
    else {
      if (round[1] === 'X') {
        // 0 for loss, 2 for paper
        myScore += 2
      } else if (round[1] === 'Y') {
        // 3 for draw, 3 for scissors
        myScore += 6
      } else {
        // 6 for win, 1 for rock
        myScore += 7
      }
    }
  }
  );
  return myScore;
}

function solve() {
  console.log(`Solving year ${YEAR} day ${DAY} part ${PART}`)
  const input = readFile(inputFilePath);
  const whatWasThrownEachRound = formatInputAsArrayOfTupleChars(input);
  const answer = myTotalScore(whatWasThrownEachRound)
  console.log(answer);
}

solve();