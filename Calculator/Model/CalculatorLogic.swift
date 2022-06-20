//
//  calculatorLogic.swift
//  Calculator
//
//  Created by Kenneth Sidibe on 2022-06-20.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorLogic {
    
    private var isFinishedTypingNumber = true
    
    func calculate(operand:Double, operatorFunc:String) -> Double {
        
        if operatorFunc == "+/-" {
            return operand * -1
        }
        else if operatorFunc == "%" {
            return operand * 0.01
        }
        else if operatorFunc == "AC" {
            return 0
        }
        else {
            return operand
        }
    }
    
    mutating func finishedTyping() {
        self.isFinishedTypingNumber = true
    }
    mutating func currentlyTypingNumber() {
        self.isFinishedTypingNumber = false
    }
    func isFinishedTyping() -> Bool {
        return isFinishedTypingNumber ? true : false
    }
    
    mutating func setDisplayText(currentDisplayText:String, numValuePressed:String) -> String {
        
        guard let currentDisplayValue = Double(currentDisplayText) else {
            print(currentDisplayText)
            fatalError("Cannot convert displayLabelText to double.")
        }
                
        if self.isFinishedTyping() {
//            if the number has been entered completely we reset everything to 0
//
            
            self.currentlyTypingNumber()
            
            return numValuePressed
        }
        else {
            if numValuePressed == "." {
                // we check if the current number displayed is an integer or not
                
                let isInt = floor(currentDisplayValue) == currentDisplayValue
                
                if !isInt {
                    // if it is not we do not allow another "." to be added
                    
                    return currentDisplayText
                    
                }
            }
            
//            We return the current displayed text with the added number pressed
            return currentDisplayText + numValuePressed
            
        }
    }
    
}
