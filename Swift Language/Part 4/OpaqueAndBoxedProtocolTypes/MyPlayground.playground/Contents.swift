import UIKit
import Foundation
import Darwin

protocol Shape {
    func area() -> Double
    func perimeter() -> Double
}

class Circle : Shape {
    let radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func area() -> Double {
        return .pi * pow(radius, 2)
    }
    
    func perimeter() -> Double {
        return Double(2 * .pi * radius)
    }
}

class Rectangle : Shape {
    let width: Double
    let length: Double
    
    init(width: Double, length: Double) {
        self.width = width
        self.length = length
    }
    
    func area() -> Double {
        return (width * length)
    }
    
    func perimeter() -> Double {
        return 2 * (width + length)
    }
}

func generateShape() -> some Shape {
    return Circle(radius: 5)
}

func calculateShapeDetails() -> (Double, Double) {
    let shape = generateShape()
    
    return (shape.area(), shape.perimeter())
}
