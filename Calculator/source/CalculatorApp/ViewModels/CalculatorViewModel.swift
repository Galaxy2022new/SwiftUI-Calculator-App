//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Robert on 2024/11/3.
//

import Foundation
import Combine
import Expression

class CalculatorViewModel: ObservableObject {
    @Published var expression = "" // 用户显示的表达式
    @Published var currentInput = "0"
    @Published var history: [String] = []
    
    private let operatorsMap: [String: String] = [
        "x": "*",
        "÷": "/"
    ]

    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide:
            appendOperator(button: button)
        case .equal:
            calculateResult()
        case .clear:
            clear()
        case .decimal:
            addDecimal()
        case .percent:
            convertToPercent()
        default:
            addToInput(button: button)
        }
    }
    
    private func clear() {
        expression = ""
        currentInput = "0"
    }

    private func addDecimal() {
        if !currentInput.contains(".") {
            currentInput += "."
            expression += "."
        }
    }

    private func convertToPercent() {
        if let value = Double(currentInput) {
            let percentValue = value / 100
            currentInput = "\(percentValue)"
            expression = "\(expression)%"
        }
    }

    private func addToInput(button: CalcButton) {
        if currentInput == "0" {
            currentInput = button.rawValue
        } else {
            currentInput += button.rawValue
        }
        expression += button.rawValue
    }

    private func appendOperator(button: CalcButton) {
        let operatorSymbol = button.rawValue
        expression += operatorSymbol
        currentInput = ""
    }

    private func calculateResult() {
        let sanitizedExpression = sanitizeExpression(expression)
        do {
            let result = try Expression(sanitizedExpression).evaluate()
            currentInput = "\(result)"
            history.append("\(expression) = \(result)")
            expression = "\(result)"
        } catch {
            currentInput = "Error"
        }
    }

    /// 将用户输入的表达式转换为可计算的表达式
    private func sanitizeExpression(_ input: String) -> String {
        var sanitized = input
        for (key, value) in operatorsMap {
            sanitized = sanitized.replacingOccurrences(of: key, with: value)
        }
        return sanitized
    }
}

