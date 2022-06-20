//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var calculatorLogic = CalculatorLogic()
    @IBOutlet weak var displayLabel: UILabel!
    private var displayValue:Double {
        
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("cannot convert displayLabel to double.")
            }
            
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        
        calculatorLogic.finishedTyping()
        
        if let calcMethod = sender.currentTitle {
            
            displayValue = calculatorLogic.calculate(operand: displayValue, operatorFunc: calcMethod)
            
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if let numValue = sender.currentTitle {
            
            displayLabel.text = calculatorLogic.setDisplayText(currentDisplayText: displayLabel.text!, numValuePressed: numValue)
            
//            if calculatorLogic.isFinishedTyping() {
//
//                //  We reset the value of the displayLabel
//
//                displayLabel.text = numValue
//                calculatorLogic.currentlyTypingNumber()
//
//            } else {
//                //  If we hit the decimal button
//                if numValue == "." {
//                    // we check if the current number displayed is an integer or not
//
//                    let isInt = floor(displayValue) == displayValue
//
//
//                    if !isInt {
//
//                        // if it is not we do not allow another "." to be added
//
//                        return
//                    }
//                }
//
//                // We add the numValue tapped to the displayLabel
//                displayLabel.text! += numValue
//            }
        }
    }
    
}

