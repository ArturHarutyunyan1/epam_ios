import UIKit

class Stack<T> {
    var stack: [T] = []
    
    func push(_ element: T) {
        stack.append(element)
    }
    
    func pop() -> T? {
        return stack.popLast()
    }
    
    func size() -> Int {
        return stack.count
    }
    
    func printStackContents() -> String {
        var str: String = ""
        for item in stack {
            str.append("\(item) ")
        }
        return str
    }
}


//let myStack = Stack<Int>()
//
//myStack.printStackContents()
//
//print(myStack.printStackContents())
//print(myStack.size())
//print(myStack.pop())
//
//print(myStack.printStackContents())
//print(myStack.size())
