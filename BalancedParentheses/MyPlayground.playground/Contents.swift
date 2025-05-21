import UIKit
import Foundation

func solution(_ str1: String, _ str2: String) -> Int {
    for (index, value) in str1.enumerated() {
        var val = Array(str1)
        val.remove(at: index)
        
        if String(val) == str2 {
            return index
        }
    }
    return -1
}


print(solution("haello", "hello"))
