import UIKit

public func isBalancedParentheses(input: String) -> Bool {
    var stack: [Character] = []
    for char in input {
        if char != "(" && char != ")" {
            continue
        }
        if char == "(" {
            stack.insert(char, at: 0)
        } else if char == ")" {
            if stack.isEmpty {
                return false
            }
            stack.remove(at: 0)
        }
    }
    return stack.isEmpty
}

