//
//  ScientificCalcButton.swift
//  Calculator
//
//  Created by Robert on 2024/11/3.
//

import SwiftUI

enum ScientificCalcButton: String, CaseIterable, Comparable {
    case clear = "AC"
    case percent = "%"
    case divide = "/"
    case multiply = "*"
    case subtract = "-"
    case add = "+"
    case equals = "="
    case decimal = "."
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case pi = "π"
    case e = "e"
    case sqrt = "√"
    case xCubed = "x^3"
    case xSquared = "x²"
    case xToThePowerOfY = "x^y"
    case factorial = "x!"
    case oneOverX = "1/x"
    case log = "log"
    case sine = "sin"
    case cosine = "cos"
    case tangent = "tan"

    static func < (lhs: ScientificCalcButton, rhs: ScientificCalcButton) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension ScientificCalcButton {
    var isUnaryOperation: Bool {
        switch self {
        case .sqrt, .xCubed, .xSquared, .factorial, .oneOverX, .log, .sine, .cosine, .tangent:
            return true
        default:
            return false
        }
    }
    
    var isBinaryOperation: Bool {
        switch self {
        case .add, .subtract, .multiply, .divide:
            return true
        default:
            return false
        }
    }
    
    var operation: String? {
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        default: return nil
        }
    }
    
    var numberValue: Double? {
        switch self {
        case .zero: return 0
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        default: return nil
        }
    }
    
    var buttonColor: Color {
        switch self {
        case .clear, .percent:
            return Color(.lightGray)
        case .add, .subtract, .multiply, .divide, .equals:
            return .orange
        default:
            return Color(.darkGray)
        }
    }
}
