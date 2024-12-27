//
//  ScientificCalculatorViewModel.swift
//  Calculator
//
//  Created by Robert on 2024/11/3.
//

import Foundation
import Combine

class ScientificCalculatorViewModel: ObservableObject {
    @Published var expression = ""
    @Published var currentInput = ""
    @Published var history: [String] = []
    
    private var runningNumber = 0.0
    private var currentOperation: Operation? = nil
    
    enum Operation: String {
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case none = ""
    }
    
    func didTap(button: ScientificCalcButton) {
        switch button {
        case .clear:
            clear()
        case .decimal:
            addDecimal()
        case .equals:
            calculateResult()
        case .pi, .e:
            appendToCurrentInput(Double(button.rawValue) ?? 0)
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            appendToCurrentInput(button.numberValue!)
        default:
            if button.isUnaryOperation {
                applyUnaryOperation(button)
            } else if button.isBinaryOperation {
                handleOperation(button.operation ?? "")
            }
        }
    }
    
    private func clear() {
        expression = ""
        currentInput = ""
        runningNumber = 0.0
        currentOperation = nil
    }
    
    private func addDecimal() {
        if !currentInput.contains(".") {
            currentInput += "."
        }
    }
    
    private func appendToCurrentInput(_ number: Double) {
        if currentInput == "0" {
            currentInput = "\(number)"
        } else {
            currentInput += "\(number)"
        }
    }
    
    //一元操作
    private func applyUnaryOperation(_ button: ScientificCalcButton) {
        if let number = Double(currentInput) {
            switch button {
            case .sqrt:
                currentInput = "\(sqrt(number))"
            case .xCubed:
                currentInput = "\(pow(number, 3))"
            case .xSquared:
                currentInput = "\(pow(number, 2))"
            case .factorial:
                currentInput = "\(factorial(number))"
            case .oneOverX:
                currentInput = "\(1 / number)"
            case .log:
                currentInput = "\(log10(number))"
            case .sine:
                currentInput = "\(sin(number))"
            case .cosine:
                currentInput = "\(cos(number))"
            case .tangent:
                currentInput = "\(tan(number))"
            default:
                break
            }
            expression = currentInput
        }
    }
    
    //二元操作
    private func handleOperation(_ operation: String) {
        if let number = Double(currentInput) {
            if runningNumber == 0 {
                runningNumber = number
            } else {
                calculateResult()
            }
            expression = "\(runningNumber) \(operation)"
            currentInput = ""
            currentOperation = Operation(rawValue: operation)
        }
    }
    
    private func calculateResult() {
        if let number = Double(currentInput), let operation = currentOperation {
            var result: Double = 0
            switch operation {
            case .add:
                result = runningNumber + number
            case .subtract:
                result = runningNumber - number
            case .multiply:
                result = runningNumber * number
            case .divide:
                result = runningNumber / number
            case .none:
                result = number
            }
            currentInput = "\(result)"
            expression = "\(result)"
            currentOperation = nil
            runningNumber = 0
        }
    }
    
    private func factorial(_ number: Double) -> Double {
        guard number >= 0 else { return 0 }
        return Double((1...Int(number)).reduce(1, *))
    }
}
