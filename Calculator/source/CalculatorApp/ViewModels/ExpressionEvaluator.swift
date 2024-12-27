//
//  ExpressionEvaluator.swift
//  Calculator
//
//  Created by Robert on 2024/11/3.
//

import Foundation
import Expression

enum ExpressionError: Error {
    case evaluationFailed
}

func evaluateExpression(_ expression: String, range: ClosedRange<Double>) throws -> [CGFloat] {
    var values: [CGFloat] = []
    let step: Double = 0.1
    
    for value in stride(from: range.lowerBound, through: range.upperBound, by: step) {
        var e = NumericExpression(expression)
        e = NumericExpression(expression, constants: ["x": value]) // 变量是 x
        let result = try e.evaluate()
        values.append(CGFloat(result))
    }
    return values
}
