//
//  main.swift
//  Task 4
//
//  Created by Artur Harutyunyan on 03.08.25.
//

import Combine

var cancellables = Set<AnyCancellable>()

let publisher = PassthroughSubject<Int, Never>()

publisher
    .filter { $0.isMultiple(of: 2) }
    .sink { values in
        print(values)
    }
    .store(in: &cancellables)


publisher.send(1)
publisher.send(2)
publisher.send(3)
publisher.send(4)
publisher.send(5)
publisher.send(6)
publisher.send(7)
publisher.send(8)
publisher.send(9)
publisher.send(10)
