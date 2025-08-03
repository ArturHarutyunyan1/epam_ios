//
//  main.swift
//  Task 1
//
//  Created by Artur Harutyunyan on 03.08.25.
//

import Combine

let publisher = Just("Hello, Combine!")
var cancellable = Set<AnyCancellable>()

publisher.sink { value in
    print(value)
}.store(in: &cancellable)
