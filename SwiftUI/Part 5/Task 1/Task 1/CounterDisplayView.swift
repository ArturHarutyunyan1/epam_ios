//
//  CounterDisplayView.swift
//  Task 1
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import SwiftUI

struct CounterDisplayView: View {
    @EnvironmentObject var counter: Counter
    var body: some View {
        Text("\(counter.counterValue)")
            .font(
                .system(
                    size: 82,
                    weight: .bold,
                    design: .rounded
                )
            )
    }
}
