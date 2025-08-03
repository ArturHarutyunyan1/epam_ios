//
//  main.swift
//  Task 6
//
//  Created by Artur Harutyunyan on 03.08.25.
//

import Combine

var cancellables = Set<AnyCancellable>()
let publisher = PassthroughSubject<Int, Never>()

publisher
    .flatMap { Just($0 * $0) }
    .sink { value in
        print(value)
    }
    .store(in: &cancellables)

publisher.send(2)
publisher.send(3)
publisher.send(4)
publisher.send(5)
