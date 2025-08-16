//
//  IncrementCounterView.swift
//  Task 1
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import SwiftUI

struct IncrementCounterView: View {
    @EnvironmentObject var counter: Counter
    var body: some View {
        Button {
            counter.counterValue += 1
        } label: {
            Text("+")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(width: 50, height: 50)
        }
        .buttonStyle(.borderedProminent)
        .clipShape(Circle())
    }
}
