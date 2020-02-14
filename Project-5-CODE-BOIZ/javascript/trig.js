//Created by zach venables 10/29/2019
//calculates trig values in degrees or radians
function trigUtility (trigFunc){
    switch (trigFunc){
        case "sin":
            if (calc.radians) {
                calc.display = Math.sin(calc.display);
            } else {
                calc.display = Math.sin(calc.display * Math.PI/180);
            }
            break;
        case "cos":
            if (calc.radians) {
                calc.display = Math.cos(calc.display);
            } else {
                calc.display = Math.cos(calc.display * Math.PI/180);
            }
            break;
        case "tan":
            if (calc.radians) {
                calc.display = Math.tan(calc.display);
            } else {
                calc.display = Math.tan(calc.display * Math.PI/180);
            }
            break;
        case "arcsin":
            if(calc.radians){
                calc.display = Math.asin(calc.display);
            } else {
                calc.display = Math.asin(calc.display) * 180/Math.PI;
            }
            break;
        case "arccos":
            if(calc.radians){
                calc.display = Math.acos(calc.display);
            } else {
                calc.display = Math.acos(calc.display) * 180/Math.PI;
            }
            break;
        case "arctan":
            if(calc.radians){
                calc.display = Math.atan(calc.display);
            } else {
                calc.display = Math.atan(calc.display) * 180/Math.PI;
            }
            break;
    }
    updateDisplay();
}

//Created by zach Venables 10/30/2019
//swaps the value of radians and updates the calculator
function radianUtility(){
    calc.radians = !calc.radians;

    if (calc.radians) {
        document.getElementById("radians").innerHTML = "Rad";
    }else{
        document.getElementById("radians").innerHTML = "Deg";
    }
}