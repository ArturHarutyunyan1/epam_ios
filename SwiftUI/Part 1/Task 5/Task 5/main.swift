//
//  main.swift
//  Task 5
//
//  Created by Artur Harutyunyan on 03.08.25.
//

import Combine
import Foundation

var cancellables = Set<AnyCancellable>()
let publisher = PassthroughSubject<String, Never>()

publisher
    .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
    .sink { value in
    print(value)
}
.store(in: &cancellables)

publisher.send("H")
publisher.send("He")
publisher.send("Hel")
publisher.send("Hell")
publisher.send("Hello")

RunLoop.main.run(until: Date().addingTimeInterval(1.2))
