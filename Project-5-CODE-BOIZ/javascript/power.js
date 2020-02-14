/* File created on 10/30/2019 by Matthew Kelch
 *
 * This file contains logic for the power functions (squared, cubed, square root, reciprocal)
 */

/*
 * Added on 10/30/2019 by Matthew Kelch
 *
 * Performs power operations based on the button clicked
 */
function power(clickedButton) {
    // Determine which button was pressed
    let powerFunction = clickedButton.id;

    // Perform selected memory button action
    switch (powerFunction) {
        // Clear memory
        case "square":
            square();
            break;
        case "cube":
            cube();
            break;
        case "sqrt":
            sqrt();
            break;
        case "recip":
            recip();
            break;
        default:
            // Error if code reaches this point
            console.log("Error: " + powerFunction + " is not a valid function.");
    }

    updateDisplay();
}

// TODO display needs to be strings instead of numbers???? Can't remember/not sure

// Added on 10/30/2019 by Matthew Kelch
function square() {
    calc.display = Math.pow(parseFloat(calc.display), 2);
}

// Added on 10/30/2019 by Matthew Kelch
function cube() {
    calc.display = Math.pow(parseFloat(calc.display), 3);
}

// Added on 10/30/2019 by Matthew Kelch
function sqrt() {
    calc.display = Math.sqrt(parseFloat(calc.display));
}

// Added on 10/30/2019 by Matthew Kelch
function recip() {
    if (calc.display != "0") {
        calc.display = 1/parseFloat(calc.display);
    }
}