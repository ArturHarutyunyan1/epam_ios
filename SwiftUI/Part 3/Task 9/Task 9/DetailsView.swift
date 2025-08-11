//
//  DetailsView.swift
//  Task 9
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct DetailsView: View {
    @State var isPresented: Bool = false
    let fruit: Fruit
    
    var body: some View {
        VStack {
            Text("\(fruit.name)")
                .font(.headline)
            Button("Show details about \(fruit.name)") {
                isPresented = true
            }
        }
        .sheet(isPresented: $isPresented) {
            Text("\(fruit.details)")
        }
    }
}
