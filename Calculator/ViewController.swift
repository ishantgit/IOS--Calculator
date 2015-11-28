//
//  ViewController.swift
//  Calculator
//
//  Created by ishant on 22/11/15.
//  Copyright © 2015 ishant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    // can infer by its own
   // var userIsTyping: Bool = false

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTyping{
            enter()
        }
        switch operation {
        case "×": performOperation{ $0 * $1}
        case "÷": performOperation{ $1 / $0}
        case "+": performOperation{ $0 + $1}
        case "−": performOperation{ $1 - $0}
        default :break
        }
    }
    
    
    func performOperation(operation: (Double,Double)->Double){
        if operandStack.count>=2{
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle! // unwrap the optional and crash if its nil
        if userIsTyping{
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsTyping = true
        }
    
//        print("digit = + \(digit)")
    }
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsTyping = false
        operandStack.append(displayValue)
        print("operandStack + \(operandStack)")
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
        }
    }
}

