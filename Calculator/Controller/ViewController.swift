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
            if displayLabel.text == "." {
                return 0.0
            }
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
        calculatorLogic.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            guard let calcValue = calculatorLogic.calculate(symbol: calcMethod) else {
                fatalError("Returned value of calculate method was nil.")
            }
            
            displayValue = calcValue
            calculatorLogic.setNumber(displayValue)
            
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if let numValue = sender.currentTitle {
            
            displayLabel.text = calculatorLogic.setDisplayText(currentDisplayText: displayLabel.text!, numValuePressed: numValue)
            
        }
    }
    
}

