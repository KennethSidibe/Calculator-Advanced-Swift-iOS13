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
    private var number:Double?
    private var intermediateCalculation: (n1:Double, calcMethod:String)?
    
    mutating func calculate(symbol:String) -> Double? {
        
        if let n = number {
            
            if symbol == "+/-" {
                return n * -1
            }
            else if symbol == "%" {
                return n * 0.01
            }
            else if symbol == "AC" {
                return 0
            }
            else if symbol == "=" {
//                checking if we have two numbers to perfom the calculation
                
                if intermediateCalculation != nil {
                    
                    let result = perfomTwoNumCalculation(n2: n)
//                    We reset the intermediate number saved to not add more than necessary
                    resetIntermediateCalculation()
                    return result
                }
                else {
//                    if the user has just tapped one number we return it as it is
                    return n
                }
            }
            
            else {
                intermediateCalculation = (n1:n, calcMethod:symbol)
            }
        }
        return number
    }
    
    private mutating func perfomTwoNumCalculation(n2:Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,
           let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "÷":
                return n1 / n2
            case "×":
                return n1 * n2
            default:
                fatalError("Could not find correct operator for operation")
            }
        }
        return nil
    }
    
    mutating func finishedTyping() {
        self.isFinishedTypingNumber = true
    }
    private mutating func resetIntermediateCalculation(){
        intermediateCalculation?.n1 = 0
        intermediateCalculation?.calcMethod = "+"
    }
    mutating func currentlyTypingNumber() {
        self.isFinishedTypingNumber = false
    }
    func isFinishedTyping() -> Bool {
        return isFinishedTypingNumber ? true : false
    }
    mutating func setNumber(_ number:Double) {
        self.number = number
    }
    
    mutating func setDisplayText(currentDisplayText:String, numValuePressed:String) -> String {
        
        if currentDisplayText == "." && (Int(numValuePressed) != nil) {
            //            For the special cas where the user tap "." first and any numeric value after
            
            return "0" + currentDisplayText + numValuePressed
        }
        
        guard let currentDisplayValue = Double(currentDisplayText) else {
            fatalError("Cannot convert displayLabelText to double.")
        }
        
        if self.isFinishedTyping() {
            //            if the number has been entered completely we reset everything to 0
            
            self.currentlyTypingNumber()
            
            return numValuePressed
        }
        
        else {
            if numValuePressed == "." {
                // we check if the current number displayed is an integer or not
                
                let isInt = floor(currentDisplayValue) == currentDisplayValue
                
                if !isInt {
                    // if it is not we do not allow another "." to be added
                    
                    self.number = currentDisplayValue
                    return currentDisplayText
                }
            }
            
            //  We return the current displayed text with the added number pressed
            self.number =  Double(currentDisplayText + numValuePressed)!
            return currentDisplayText + numValuePressed
            
        }
    }
    
}
