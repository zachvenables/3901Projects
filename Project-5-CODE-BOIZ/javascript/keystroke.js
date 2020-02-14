//Created by Zach Venables 10/29/2019
//waits for keypress event and deals with it appropraitely

document.addEventListener("keypress", event => {
    event.preventDefault();
    let key = event.key;

    if (!isNaN(key)){
        appendDigit(key);
    } else if (key === "+" || key === "-" || key === "*" || key === "/") {
        operatorUtility(key);
    } else if (key === "Enter"){
        equalsUtility();
    } else if (key === "Separator" || key === "Decimal" || key === "."){
        makeDecimal();
    }
}, false);
