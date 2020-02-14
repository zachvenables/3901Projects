// File created on 10/20/2019 by Matthew Kelch
// Edited 10/21/19 by Sean Simpson
// Edited on 10/23/2019 by Andrew Petrilli - adding memory button functionality
// Edited 10/23/19 by Sean Simpson - Neg/Pos change and decimal functionality
// Edited on 10/24/2019 by Matthew Kelch - Added C, CE, Delete button functionality
// Edited on 10/26/2019 by Andrew Petrilli - Refactoring : moving memory functionality logic to separate file
// Edited on 10/30/2019 by Neil Mckibben - Prototyping everything

// This file defines the logic to handle button clicks and respond accordingly

// Declare global calc variable
var calc;

//Added 10/21/19 by Sean Simpson
//Mathematical operation selection for the arithmetic calculation
function selection(choice){
  this.choice = choice;
  this.arithmetic();
}

//Added 10/21/19 by Sean Simpson
// Edited on 10/23/2019 by Andrew Petrcalcilli - removed memory updating
//Based on the operation selection, computes arithmetic based on the selection
function arithmetic(){
  switch(calc.operator){
    case "+":
      return parseFloat(calc.accumulator) + parseFloat(calc.display);
    case "-":
      return parseFloat(calc.accumulator) - parseFloat(calc.display);
    case "*":
      return parseFloat(calc.accumulator) * parseFloat(calc.display);
    case "/":
      return parseFloat(calc.accumulator) / parseFloat(calc.display);
  }
}

/*
 * Updates the HTML to reflect whatever is currently stored in calc.display
 * Created on 10/20/2019 by Matthew Kelch
 */
function updateDisplay() {
  document.getElementById("display").innerHTML = calc.display;
}

/*
 * Appends @param digit to calc.display. If the display is currently 0, then the digit replaces the 0 instead.
 * Updates the HTML to reflect the change.
 *
 * Created on 10/20/2019 by Matthew Kelch
 * Edited on 10/27/2019 added if block to deal with case after operator is pressed
 */
function appendDigit(digit) {
  if (calc.requireSecondOperand === true){
    calc.display = digit;
    calc.requireSecondOperand = false;
  } else if (calc.display === 0) {
    calc.display = digit;
  } else {
    calc.display = "" + calc.display + digit;
  }
  this.updateDisplay();
}


//Created by zach venables 10/22
//handles the case where = is pressed by completing the next operation and setting operator to null
function equalsUtility(){
  let result;
  if(calc.operator == null){
    return;
  }
  result = arithmetic();
  calc.accumulator = result;
  calc.display = result;
  calc.operator = null;
  calc.requireSecondOperand = true;
  this.updateDisplay();
}

// Created by Zach Venables 10/21
// Edited on 10/23/2019 by Andrew Petrilli - removed memory updating
// Edited 10/31/2019 by Zach Venables, reorganized code to make it cleaner/ readable
// Handles the case where an operator is pressed by completing the previous operation, updating the accumulator
function operatorUtility(nextOperator){
  //edited 10/30 by Zach
  //if operator is continuously pressed with no operand nothing happens
  if(calc.requireSecondOperand && calc.operator !== null){
    return;
  }

  /*if there is no value in accumulator then it becomes the display value*/
  if (calc.accumulator === null){
    calc.accumulator = parseFloat(calc.display);
    calc.requireSecondOperand = true;
    calc.operator = nextOperator;
    return;
  }else if(calc.operator == null){//this only executes after an equals has been pressed and then more operations occur
    if (calc.accumulator != calc.display){//you don't want to use the value on screen after equals is pressed
      calc.accumulator = calc.display;
    }
    calc.operator = nextOperator;
    calc.requireSecondOperand = true;
    return;
  }
  //if no special cases than execute the operation
  calc.display = arithmetic();
  calc.accumulator = calc.display;
  calc.operator = nextOperator;
  calc.requireSecondOperand = true;
  calc.updateDisplay();
}

//Added 10/23/19 by Sean Simpson
//Changes the value into either a positive or negative value
function negPosVal(){
  let changeVal = -1;
  let num = parseFloat(calc.display);
  num *= changeVal;
  calc.display = num;
  calc.updateDisplay();
}

//Added 10/23/19 by Sean Simpson
//Adds a decimal value to the number if none exists on the number
function makeDecimal(){
  let checkString = "" + calc.display;
  if(!(checkString.includes("."))){
    calc.display = calc.display + ".";
  }
  calc.updateDisplay();
}


/*
 * Processes events when CE, C, or Delete button is pressed
 * Created on 10/24/2019 by Matthew Kelch
 */
function erase(clickedButton) {
  let button = clickedButton.id;

  switch (button) {
    // If c button is pressed, reset everything in calculator except for memory
    case "c":
      calc.display = 0;
      calc.accumulator = null;
      calc.operator = null;
      calc.requireSecondOperand = false;

    // If ce button is pressed, only delete the most-recent number
    case "ce":
      calc.display = 0;

    // If delete button is pressed, only delete most-recent digit
    case "delete":
      if (calc.display.toString().length == 1) {
        calc.display = 0;
      } else {
        calc.display = calc.display.toString().substring(0, calc.display.toString().length - 1);
      }
  }
  // Process changes to calc display before exiting
  calc.updateDisplay();
}

/*
 * display property is the value that is currently on the calculator's display
 * memory property is a stack of numbers that were previously on the calculator's display
 * Created on 10/20/2019 by Matthew Kelch
 */
function Calculator(firstNum, secondNum) {
  this.display = 0;
  this.accumulator = null;
  this.operator = null;
  this.requireSecondOperand = false;
  this.memory = [];
  this.firstNum = firstNum;
  this.secondNum = secondNum;
  //Function definitions for basic calculator
  this.appendDigit = appendDigit;
  this.operatorUtility = operatorUtility;
  this.equalsUtility = equalsUtility;
  this.memoryUtility = memoryUtility;
  this.negPosVal = negPosVal;
  this.makeDecimal = makeDecimal;
  this.erase = erase;
  this.updateDisplay = updateDisplay
}

function ExtendedCalculator(firstNum, secondNum) {
    this.memoryUtility = memoryUtility;
}

function ScientificCalculator(firstNum, secondNum){
    this.memoryUtility = memoryUtility;
    this.trigUtility = trigUtility;
    this.radianUtility = radianUtility;
    this.power = power;
    this.trigUtility = trigUtility
    this.radianUtility = radianUtility
}

function setCalculator(event) {
    let calcType = document.getElementById("calculatorType");
    let calcTable = document.getElementById("calculator");
    let mem = document.getElementsByName("memory");
    let buttons = document.getElementsByClassName("button");
    switch(calcType.value){
        case 'none':
            calc = null;
            calcTable.style.visibility = "hidden";
            break;
        case 'basic':
            calc =  new Calculator();


            calcTable.style.visibility = "visible";
            for (let row of mem){
                row.style.display = "none"
            }
            for (let button of buttons){
                if (button.classList.contains("trig")) {
                  button.style.visibility = "hidden"
                }
                if (button.classList.contains("power")) {
                  button.style.visibility = "hidden"
                }
            }
            break;
        case 'extended':
            calc = new ExtendedCalculator();
            calcTable.style.visibility = "visible";
            for (let b of mem){
                b.style.display = "table-row";
            }
            for (let button of buttons){
                if (button.classList.contains("trig")) {
                  button.style.visibility = "hidden"
                }
                if (button.classList.contains("power")) {
                  button.style.visibility = "hidden"
                }
            }
            break;
        case 'scientific':
            calc = new ScientificCalculator();
            for (let b of mem){
                b.style.display = "table-row";
            }
            for (let button of buttons){
                if (button.classList.contains("trig")) {
                  button.style.visibility = "visible"
                }
                if (button.classList.contains("power")) {
                  button.style.visibility = "visible"
                }
            }

            break;
    }
}



// After the page has loaded, creates a global Calculator object and updates its display with default value 0
// Created on 10/20/2019 by Matthew Kelch
// Edited on 10/23/2019 by Andrew Petrilli - added else if for memory button press
// Edited 10/23/19 by Sean Simpson - Positive/Negative val change added
// Edited 10/30 by Zach Venables - Added radian and trig functions
window.onload = function() {
  ExtendedCalculator.prototype = new Calculator();
  ExtendedCalculator.prototype.constructor = ExtendedCalculator;
  ScientificCalculator.prototype = new Calculator();
  ScientificCalculator.prototype.constructor = ScientificCalculator;






  calc = new ScientificCalculator(); //Initial values fo the calculator
  document.getElementById("display").innerHTML = calc.display;
  let calcType = document.getElementById("calculatorType");
  calcType.addEventListener("click", setCalculator);

  let buttons = document.getElementsByClassName("button");
  for (let button of buttons) {
    button.addEventListener("click", event => {
      let clickedButton = event.target;

      if (clickedButton.classList.contains("digit")) {
        calc.appendDigit(Number(clickedButton.id));
      } else if(clickedButton.classList.contains("operator")) {
        calc.operatorUtility(clickedButton.id)
      } else if (clickedButton.classList.contains("equals")) {
        calc.equalsUtility();
      } else if (clickedButton.classList.contains("memory")) {
        calc.memoryUtility(clickedButton);
      } else if (clickedButton.classList.contains("value")) {
        calc.negPosVal();
      } else if (clickedButton.classList.contains("decimal")) {
        calc.makeDecimal();
      } else if (clickedButton.classList.contains("erase")) {
        calc.erase(clickedButton);
      } else if (clickedButton.classList.contains("trig")) {
        calc.trigUtility(clickedButton.id);//in trig.js
      } else if (clickedButton.classList.contains("radians")) {
        calc.radianUtility();//in trig.js
      } else if (clickedButton.classList.contains("power")) {
        calc.power(clickedButton);
      }
      // TODO add more else-ifs for each different button class we have
      /**/
    }, false);
  }

};
