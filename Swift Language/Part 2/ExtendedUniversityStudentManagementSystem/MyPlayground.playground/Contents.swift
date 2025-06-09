import UIKit

class Person {
    var name: String
    var age: Int
    static let minAgeForEnrollment = 16
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    convenience init?(name: String, minAge: Int) {
        guard minAge >= 16 else {return nil}
        self.init(name: name, age: minAge)
    }
    
    var isAdult: Bool {
        guard age >= 18 else {return false}
        return true
    }
    lazy var profileDescription: String = {
        return "\(name) is \(age) years old."
    }()
    deinit {
        print("Deinit")
    }
}

@MainActor
class Student : Person {
    var studentID: String
    var major: String
    static var studentCount = 0
    weak var professor: Professor?
    
    required init(studentID: String, major: String, name: String, age: Int) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        Student.studentCount += 1
    }
    
    convenience init(name: String, age: Int, studentID: String) {
        self.init(studentID: studentID, major: "Undeclared", name: name, age: age)
    }
    
    var formattedID: String {
        return "ID: " + studentID.uppercased()
    }
    deinit {
        print("Deinit")
    }
}

@MainActor
class Professor : Person {
    var faculty: String
    static var professorCount = 0
    init(faculty: String, name: String, age: Int) {
        self.faculty = faculty
        super.init(name: name, age: age)
        Professor.professorCount += 1
    }
    var fullTitle: String {
        return "Professor \(name), Faculty of \(faculty)"
    }
    deinit {
        print("Deinit")
    }
}

struct University {
    var name: String
    var location: String
    var description: String {
        return "University of \(name) in \(location)"
    }
}
