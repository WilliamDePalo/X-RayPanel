// Copyright (C) 2015 The Qt Company Ltd.

var curVal = 0
var memory = 0
var lastOp = ""
var previousOperator = ""
var digits = ""
var itemIdx = 0

function disabled(op) {
    if (op == "✔")
        display.fontColor="#000000"

    if (op=="X")
        return false
    else if (op == "✔" && (digits.toString().search(/\./) != -1  || digits.toString().search(/-/)!= -1 || parseInt(digits)>valueSource.maxMsecValue)) {
        display.fontColor="#ff0000"
        return true
    }
    else if (digits == "" && !((op >= "0" && op <= "9") || op == "."))
        return true
    else if (op == '=' && previousOperator.length != 1)
        return true
    else if (op == "." && digits.toString().search(/\./) != -1) {
        return true
    } else if (op == "√" &&  digits.toString().search(/-/) != -1) {
        return true
    } else {
        return false
    }
}

function digitPressed(op)
{
    if (disabled(op))
        return
    if (digits.toString().length >= display.maxDigits)
        return
    if (lastOp.toString().length == 1 && ((lastOp >= "0" && lastOp <= "9") || lastOp == ".") ) {
        digits = digits + op.toString()
        display.appendDigit(op.toString())
    } else {
        digits = op
        display.appendDigit(op.toString())
    }
    lastOp = op
}
function setItem(num)
{
   itemIdx = num
}

function operatorPressed(op)
{
    var form_digits = ""
    if (disabled(op))
        return
    lastOp = op

    if (op == "±") {
            digits = Number(digits.valueOf() * -1)
            display.setDigit(display.displayNumber(digits))
            return
        }

    if (previousOperator == "+") {
        digits = Number(digits.valueOf()) + Number(curVal.valueOf())
    } else if (previousOperator == "−") {
        digits = Number(curVal.valueOf()) - Number(digits.valueOf())
    } else if (previousOperator == "×") {
        digits = Number(curVal) * Number(digits.valueOf())
    } else if (previousOperator == "÷") {
        digits = Number(curVal) / Number(digits.valueOf())
    }

    if (op == "+" || op == "−" || op == "×" || op == "÷") {
        previousOperator = op
        curVal = digits.valueOf()
        digits = ""
        display.displayOperator(previousOperator)
        return
    }

    if (op == "=") {
        display.newLine("=", digits.valueOf())
    }

    curVal = 0
    previousOperator = ""

    if (op == "1/x") {
        digits = (1 / digits.valueOf()).toString()
    } else if (op == "x^2") {
        digits = (digits.valueOf() * digits.valueOf()).toString()
    } else if (op == "Abs") {
        digits = (Math.abs(digits.valueOf())).toString()
    } else if (op == "Int") {
        digits = (Math.floor(digits.valueOf())).toString()
    } else if (op == "√") {
        digits = Number(Math.sqrt(digits.valueOf()))
        display.newLine("√", digits.valueOf())
    } else if (op == "mc") {
        memory = 0;
    } else if (op == "m+") {
        memory += digits.valueOf()
    } else if (op == "mr") {
        digits = memory.toString()
    } else if (op == "m-") {
        memory = digits.valueOf()
    } else if (op == "backspace") {
        digits = digits.toString().slice(0, -1)
        display.clear()
        display.appendDigit(digits)
    } else if (op == "✔") {
        scompare.running = true
        if (itemIdx === key_mSec)
        {
            parseInt(digits)
            // gestire gli zeri max 4 cifre MS01500 l'ultimo zero viene aggiunto poi
            if (digits.toString().length<4)
                form_digits = "0"
            if (digits.toString().length<3)
                form_digits += "0"
            if (digits.toString().length<2)
                form_digits += "0"
            form_digits += digits.toString()
        }
        else if (itemIdx === 2)
        {
            // gestire gli zeri max 3 cifre
            if (digits.toString().length<3)
                form_digits = "0"+ digits.toString()
        }
        panelKeyPad.setIdxValue(itemIdx,form_digits )
       // boxCommPos.value=parseInt(digits)
        display.clear()
        curVal = 0
        memory = 0
        lastOp = ""
        digits = ""

    } else if (op == "X") {
        scompare.running = true
        display.clear()
        curVal = 0
        memory = 0
        lastOp = ""
        digits = ""
    }

    // Reset the state on 'C' operator or after
    // an error occurred
    if (op == "C" || display.isError) {
        display.clear()
        curVal = 0
        memory = 0
        lastOp = ""
        digits = ""
    }
}
