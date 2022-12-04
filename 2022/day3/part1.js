import { readFile, formatInputAsLineStringsAray } from "../../js-helpers.js";
const YEAR = process.env["YEAR"]
const DAY = process.env["DAY"]
const PART = process.env["PART"]
const inputFilePath = `./${YEAR}/day${DAY}/input.txt`

function sumUpCommonCharValues(arrayOfStrings) {
  let sumOfCharValues = 0;
  arrayOfStrings.forEach((str) => {
    const half1 = str.slice(0, str.length/2)
    const half2 = str.slice(str.length/2, str.length)
    console.log(`the two halves of ${str} are ${half1} and ${half2}`)
    const commonChar = findCommonChar(half1, half2)
    // console.log(`commonChar: ${commonChar}`)
    const numericValue = numericValueOfChar(commonChar)
    sumOfCharValues += numericValue
  })
  return sumOfCharValues;
}

// ASCII codes: 65 - 90 are uppercase letters, 97-122 are lowercase
function numericValueOfChar(char) {
  const uppercaseCharCodes = Array.from(Array(26)).map((e, i) => i + 65);
  const uppercaseAlphabet = uppercaseCharCodes.map((x) => String.fromCharCode(x));
  const lowercaseCharCodes = Array.from(Array(26)).map((e, i) => i + 97);
  const lowercaseAlphabet = lowercaseCharCodes.map((x) => String.fromCharCode(x));
  const lowercaseUppercaseAlphabetArray = ['placeholder-for-zero-index'].concat(lowercaseAlphabet, uppercaseAlphabet)
  // console.log(lowercaseUppercaseAlphabetArray)
  console.log(`the value of ${char} is ${lowercaseUppercaseAlphabetArray.indexOf(char)}`)
  return lowercaseUppercaseAlphabetArray.indexOf(char)
}

// take in two strings
// return the first char that is in both str1 and str2
function findCommonChar(str1, str2) {
  for (const char of str2) {
    if (str1.includes(char)) {
      console.log(`char: ${char}, ${str1.includes(char)}`)
      return char
    }
  }
}

function solve() {
  console.log(`Solving year ${YEAR} day ${DAY} part ${PART}`)
  const input = readFile(inputFilePath);
  const rucksacksArray = formatInputAsLineStringsAray(input)
  const answer = sumUpCommonCharValues(rucksacksArray);
  console.log(answer);
}

solve();