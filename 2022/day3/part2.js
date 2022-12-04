import { readFile, formatInputAsLineStringsAray } from "../../js-helpers.js";
const YEAR = process.env["YEAR"]
const DAY = process.env["DAY"]
const PART = process.env["PART"]
const inputFilePath = `./${YEAR}/day${DAY}/input.txt`

// take in 3 strings, return the char that is present in all three
function findCommonChar(str1, str2, str3) {
  let str1AndStr2Chars = []
  for (const char of str2) {
    if (str1.includes(char)) {
      str1AndStr2Chars.push(char)
    }
  }
  for (const char of str3) {
    if (str1AndStr2Chars.includes(char)) {
      return char
    }
  }
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
// go through the array of strings 3 at a time
// find the common char in each group
// return the sum of the numeric values
function sumUpCommonCharValues(arrayOfStrings) {
  let sumOfCharValues = 0;

  for (let i = 0; i < arrayOfStrings.length; i+=3) {
    const commonChar = findCommonChar(arrayOfStrings[i], arrayOfStrings[i+1], arrayOfStrings[i+2])
    const numericValue = numericValueOfChar(commonChar)
    sumOfCharValues += numericValue
  }

  return sumOfCharValues;
}

function solve() {
  console.log(`Solving year ${YEAR} day ${DAY} part ${PART}`)
  const input = readFile(inputFilePath);
  const rucksacksArray = formatInputAsLineStringsAray(input)
  const answer = sumUpCommonCharValues(rucksacksArray);
  console.log(answer);
}

solve();