import * as fs from 'fs';

export function readFile(filePath) {
  return fs.readFileSync(filePath, "utf-8");
}

// take in the puzzle input and return an array of strings representing each line
export function formatInputAsLineStringsArray(input) {
  return input.split('\n')
}

// take in the puzzle input and return them formatted as an array of numbers
export function formatInputAsNumbers(input) {
  return input.split('\n').map(Number);
};

// take in puzzle input and return an array comprised of tuples
// in: 'A X\nB Y\n`
// [['A', 'X'], ['B', 'Y']]
export function formatInputAsArrayOfTupleChars(input) {
  return input.split('\n').map((line) => { return [line[0], line[2]] });
}