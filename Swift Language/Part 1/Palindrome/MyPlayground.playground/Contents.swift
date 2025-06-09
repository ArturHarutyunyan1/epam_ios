import UIKit

public func isPalindrome(input: String) -> Bool {
    let filter = input.lowercased().filter {$0.isLetter || $0.isNumber}
    
    if filter.count <= 1 {
        return true
    }
    return filter == String(filter.reversed())
}

