//
//  main.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 03.08.25.
//

import Combine
import Foundation

var cancellable = Set<AnyCancellable>()

let future = Future<String, Never> { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        promise(.success("Hello, Combine!"))
    }
}

future.sink { value in
    print(value)
}.store(in: &cancellable)

RunLoop.main.run(until: Date().addingTimeInterval(2))
