//
//  main.swift
//  Task 8
//
//  Created by Artur Harutyunyan on 03.08.25.
//

import Combine


final class LoadingViewModel {
    @Published var isLoading: Bool = false
}

var cancellables = Set<AnyCancellable>()
let vm = LoadingViewModel()

vm.$isLoading
    .dropFirst()
    .sink { value in
        print("Loading state changed to \(value)")
    }
    .store(in: &cancellables)

vm.isLoading = true
vm.isLoading = false
vm.isLoading = true
vm.isLoading = false
