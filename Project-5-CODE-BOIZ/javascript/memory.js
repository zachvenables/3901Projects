// File created on 10/26/2019 by Andrew Petrilli

// File houses logic for calculator memory functionality

// Added on 10/26/2019 by Andrew Petrilli
// Memory function utility, preforms memory operation based on memory button clicked.
function memoryUtility(clickedButton) {
    // Memory function button that was pressed
    let memFunc = clickedButton.id;

    // Perform selected memory button action
    switch (memFunc) {
        // Clear memory
        case "mc":
            memClear();
            break;
        // Recall most recent item in memory
        case "mr":
            memRecall();
            break;
        // Add calc.display to most recent item in memory
        case "mplus":
            memPlus();
            break;
        // Subtract calc.display from most recent item in memory
        case "mminus":
            memMinus();
            break;
        // Set calc.display as most recent item in memory
        case "ms":
            memSet();
            break;
        // Keep list of items added to memory, allow user to select which to recall
        // Not implemented, may not be or might be implemented as additional feature
        case "mlist":
            break;
        default:
            // Shouldn't reach here, log error if so
            console.log("Error: " + memFunc + " invalid memory function id.");
    }
}

// Added on 10/26/2019 by Andrew Petrilli
function memClear() {
    calc.memory = [];
}

// Added on 10/26/2019 by Andrew Petrilli
function memRecall() {
    if (calc.memory.length > 0) {
        calc.display = calc.accumulator = calc.memory[calc.memory.length - 1];
        updateDisplay();
    }
}

// Added on 10/26/2019 by Andrew Petrilli
function memPlus() {
    if (calc.memory.length > 0) {
        let curVal = parseFloat(calc.display);
        calc.memory[calc.memory.length - 1] += curVal;
    }
}

// Added on 10/26/2019 by Andrew Petrilli
function memMinus() {
    if (calc.memory.length > 0) {
        let curVal = parseFloat(calc.display);
        calc.memory[calc.memory.length - 1] -= curVal;
    }
}

// Added on 10/26/2019 by Andrew Petrilli
function memSet() {
    let curVal = parseFloat(calc.display);
    calc.memory.push(curVal);
}