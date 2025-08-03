//
//  main.swift
//  Task 3
//
//  Created by Artur Harutyunyan on 03.08.25.
//

import Combine

var cancellables = Set<AnyCancellable>()

let name = Just("Max")
let surname = Just("Verstappen")

name
    .map { $0.uppercased() }
    .combineLatest(surname)
    .map { $0 + " " + $1 }
    .sink { fullName in
        print(fullName)
    }
    .store(in: &cancellables)
