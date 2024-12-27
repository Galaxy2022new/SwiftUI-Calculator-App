//
//  ScientificCalculatorView.swift
//  Calculator
//
//  Created by Robert on 2024/11/3.
//

import SwiftUI

struct ScientificCalculatorView: View {
    @StateObject private var viewModel = ScientificCalculatorViewModel()
    
    let scientificButtons: [[ScientificCalcButton]] = [
        [.sqrt, .xCubed, .xSquared, .xToThePowerOfY, .factorial, .oneOverX],
        [.pi, .e, .log, .sine, .tangent, .cosine],
        [.clear, .percent, .divide, .multiply, .add, .subtract],
        [.nine, .eight, .seven, .six, .five, .four],
        [.three, .two, .one, .zero, .decimal, .equals]
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack(spacing: 5) {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(viewModel.expression)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                            .frame(width: geometry.size.width * 0.95, height: 50)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(viewModel.currentInput)
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .padding(.horizontal)
                            .frame(width: geometry.size.width * 0.95, height: 100)
                        Spacer()
                    }
                    Spacer()
                    ForEach(scientificButtons, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(row, id: \.self) { button in
                                Button(action: {
                                    viewModel.didTap(button: button)
                                }) {
                                    Text(button.rawValue)
                                        .font(.system(size: 20))
                                        .frame(width: buttonWidth(geometry: geometry), height: buttonHeight(geometry: geometry))
                                        .background(button.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(buttonWidth(geometry: geometry) / 2)
                                }
                            }
                        }
                        .padding(.bottom, 5)
                    }
                    .padding(.bottom, 0)
                }
            }
        }
    }
    
    func buttonWidth(geometry: GeometryProxy) -> CGFloat {
        let spacing: CGFloat = 35
        let totalSpacing = spacing * 5
        let width = geometry.size.width - totalSpacing
        return max(width / 4, 0)
    }

    func buttonHeight(geometry: GeometryProxy) -> CGFloat {
        let spacing: CGFloat = 90
        let totalSpacing = spacing * 6
        let height = geometry.size.height - totalSpacing
        return max(height / 5, 0)
    }
}
