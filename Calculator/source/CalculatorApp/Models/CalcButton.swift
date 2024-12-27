//
//  CalcButton.swift
//  Calculator
//
//  Created by Robert on 2024/11/3.
//

import SwiftUI

enum CalcButton: String, CaseIterable {
    case zero = "0", one = "1", two = "2", three = "3", four = "4"
    case five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    case add = "+", subtract = "-", multiply = "x", divide = "÷"
    case equal = "=", clear = "C", decimal = ".", percent = "%"
    case negative = "±"
    case history = "History"
    case scientific = "Scientific"
    case graphing = "Graphing"

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}
