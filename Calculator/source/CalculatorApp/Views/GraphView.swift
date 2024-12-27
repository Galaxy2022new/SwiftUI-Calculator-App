//
//  GraphView.swift
//  Calculator
//
//  Created by Robert on 2024/11/3.
//

import SwiftUI
import Foundation
import Expression

struct GraphView: View {
    @Binding var expression: String
    var data: [CGFloat]
    var range: ClosedRange<Double> // X轴的范围
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 绘制坐标轴
                Path { path in
                    let midY = geometry.size.height / 2
                    let midX = geometry.size.width / 2
                    
                    // X轴（宽度为画布的宽度）
                    path.move(to: CGPoint(x: 0, y: midY))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: midY))
                    
                    // Y轴（长度与画布宽度一致）
                    path.move(to: CGPoint(x: midX, y: 0))
                    path.addLine(to: CGPoint(x: midX, y: geometry.size.height))  // 使用宽度值作为 y 轴长度
                }
                .stroke(Color.gray, lineWidth: 1)
                
                // 绘制绘图区边框
                Path { path in
                    // 绘制矩形边框
                    path.move(to: CGPoint(x: 0, y: 0)) // 左上角
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0)) // 上边界
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height)) // 右下角
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height)) // 下边界
                    path.addLine(to: CGPoint(x: 0, y: 0)) // 回到左上角
                }
                .stroke(Color.black, lineWidth: 2) // 使用黑色画笔绘制边框
                
                // 绘制函数图像
                Path { path in
                    guard data.count > 1 else { return }
                    
                    let step = geometry.size.width / CGFloat(data.count - 1)
                    let midY = geometry.size.height / 2
                    
                    // 计算 y 轴的缩放比例
                    let yScale = geometry.size.height / CGFloat(range.upperBound - range.lowerBound)
                    
                    // 移动到第一个点
                    var y = midY - data[0] * yScale
                    // 限制 y 值在有效范围内
                    y = min(max(y, 0), geometry.size.height)
                    path.move(to: CGPoint(x: 0, y: y))
                    
                    for (index, value) in data.enumerated() {
                        let x = CGFloat(index) * step
                        var y = midY - value * yScale  // 这里使用 yScale 进行缩放
                        // 限制 y 值在有效范围内
                        y = min(max(y, 0), geometry.size.height)
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
                .stroke(Color.blue, lineWidth: 2)
            }
        }
        .padding()
    }
}
