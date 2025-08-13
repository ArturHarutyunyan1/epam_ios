//
//  ContentView.swift
//  Task 5
//
//  Created by Artur Harutyunyan on 13.08.25.
//

import SwiftUI

@Observable
final class FormModel {
    var username: String = ""
}

struct ContentView: View {
    @State private var formModel = FormModel()
    var body: some View {
        VStack {
            FormView(formModel: formModel)
        }
        .padding()
    }
}

struct FormView: View {
    @Bindable var formModel: FormModel
    var body: some View {
        VStack(spacing: 16) {
            TextField("Username", text: $formModel.username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button("Submit") {
                print("Username submitted: \(formModel.username)")
            }
            .buttonStyle(.borderedProminent)
            .disabled(formModel.username.isEmpty)
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
