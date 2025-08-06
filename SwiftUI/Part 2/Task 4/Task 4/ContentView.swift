//
//  ContentView.swift
//  Task 4
//
//  Created by Artur Harutyunyan on 06.08.25.
//

import SwiftUI

struct CustomToggle: ToggleStyle {
    @State private var isPressed = false

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .foregroundStyle(configuration.isOn ? .white : .black)
                .opacity(configuration.isOn ? 1 : 0.7)
                .animation(.easeInOut(duration: 0.3), value: configuration.isOn)
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(configuration.isOn ? Color.green : Color.gray.opacity(0.4))
                    .frame(width: 50, height: 30)
                    .animation(.easeInOut(duration: 0.25), value: configuration.isOn)

                HStack {
                    if configuration.isOn { Spacer() }
                    Image(systemName: configuration.isOn ? "moon.fill" : "sun.max.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(
                            Circle()
                                .fill(configuration.isOn ? Color.black.opacity(0.3) : Color.green)
                                .animation(.easeInOut(duration: 0.3), value: configuration.isOn)
                        )
                        .shadow(color: configuration.isOn ? Color.green.opacity(0.7) : .clear, radius: 8)
                        .scaleEffect(isPressed ? 1.1 : 1)
                        .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: configuration.isOn)
                    if !configuration.isOn { Spacer() }
                }
                .frame(width: 50, height: 30)
                .animation(.easeOut(duration: 0.25), value: configuration.isOn)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation(.spring()) { isPressed = true }
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) { isPressed = false }
                        configuration.isOn.toggle()
                    }
            )
        }
    }
}



struct ContentView: View {
    @State private var isOn = false
    var body: some View {
        ZStack {
            (isOn ? Color.black : Color.white)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Toggle("App theme", isOn: $isOn)
                    .toggleStyle(CustomToggle())
            }
        }
    }
}

#Preview {
    ContentView()
}
