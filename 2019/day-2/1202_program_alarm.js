const fs = require('fs');

const input = fs.readFileSync("input.txt").toString();

function adjustInputForProgram(input) {
  input_array = input.split(',').map(Number);
  input_array[1] = 12;
  input_array[2] = 2;
  return input_array;
}

function runGravityProgram(programArray) {
  let valueOnePosition, valueTwoPosition, outputPosition;
  for (let i = 0; i < programArray.length - 1; i += 4) {
    valueOnePosition = programArray[i+1];
    valueTwoPosition = programArray[i+2];
    outputPosition = programArray[i+3];
    switch(programArray[i]) {
      case 1:
        programArray[outputPosition] = programArray[valueOnePosition] + programArray[valueTwoPosition];
        break;
      case 2:
        programArray[outputPosition] = programArray[valueOnePosition] * programArray[valueTwoPosition];
        break;
      case 99:
        console.log(`The answer is ${programArray[0]}`);
        return;
      default:
        console.log("ruh roh, something's wrong");
    }
  }
}

runGravityProgram(adjustInputForProgram(input));