//
//  HistoryView.swift
//  Calculator
//
//  Created by Robert on 2024/11/3.
//

import SwiftUI

struct HistoryView: View {
    let history: [String]
    
    var body: some View {
        NavigationView {
            List(history, id: \.self) { record in
                Text(record)
            }
            .navigationTitle("历史记录")
        }
    }
}
