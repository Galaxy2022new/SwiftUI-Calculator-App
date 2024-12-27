//
//  ContentView.swift
//  Calculator
//
//  Created by Robert on 2024/11/3.
//

import SwiftUI
import Expression

struct ContentView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @State private var showingHistory = false
    @State private var showingScientificCalculator = false
    @State private var showingGraph = false
    @State private var expression = ""
    @State private var graphData: [CGFloat] = []

    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack(spacing: 12) {
                    HStack {
                        Menu("", systemImage: "list.bullet") {
                            Button(action: { showingHistory.toggle() }) {
                                Text("历史记录")
                            }
                            Button(action: { showingScientificCalculator.toggle() }) {
                                Text("科学计算器")
                            }
                            Button(action: { showingGraph.toggle() }) {
                                Text("函数图像")
                            }
                        }
                        .foregroundColor(.orange)
                        .padding()
                        .font(.title)
                        
                        Spacer()
                    }

                    Spacer()

                    VStack(spacing: 10) {
                        HStack {
                            Spacer()
                            Text(viewModel.expression)
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .lineLimit(1)
                                .padding(.horizontal)
                        }
                        HStack {
                            Spacer()
                            Text(viewModel.currentInput)
                                .foregroundColor(.white)
                                .font(.system(size: 80))
                                .lineLimit(1)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 20)

                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { button in
                                Button(action: {
                                    viewModel.didTap(button: button)
                                }) {
                                    Text(button.rawValue)
                                        .font(.system(size: 32))
                                        .frame(width: buttonWidth(button: button, geometry: geometry), height: buttonHeight(geometry: geometry))
                                        .background(button.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(buttonWidth(button: button, geometry: geometry) / 2)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showingHistory) {
                HistoryView(history: viewModel.history)
            }
            .sheet(isPresented: $showingScientificCalculator) {
                ScientificCalculatorView()
            }
            .sheet(isPresented: $showingGraph) {
                VStack {
                    TextField("Enter function expression", text: $expression)
                        .padding()
                    Button("绘制图形") {
                        self.plotFunction()
                    }
                    GraphView(expression: $expression, data: graphData, range: -10...10)
                }
            }
        }
    }

    func buttonWidth(button: CalcButton, geometry: GeometryProxy) -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing = spacing * 5
        let width = geometry.size.width - totalSpacing
        return button == .zero ? (width / 4) * 2 : width / 4
    }

    func buttonHeight(geometry: GeometryProxy) -> CGFloat {
        let spacing: CGFloat = 60
        let totalSpacing = spacing * 6
        let height = geometry.size.height - totalSpacing
        return height / 5
    }

    func plotFunction() {
        do {
            graphData = try evaluateExpression(expression, range: -10...10)
        } catch {
            print("评估表达式出错：\(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
