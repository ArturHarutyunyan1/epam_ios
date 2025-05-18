import UIKit

class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    convenience init?(name: String, minAge: Int) {
        guard minAge >= 16 else {return nil}
        self.init(name: name, age: minAge)
    }
}

class Student : Person {
    var studentID: String
    var major: String
    
    required init(studentID: String, major: String, name: String, age: Int) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
    }
    
    convenience init(name: String, age: Int, studentID: String) {
        self.init(studentID: studentID, major: "Undeclared", name: name, age: age)
    }
}


class Professor : Person {
    var faculty: String
    
    init(faculty: String, name: String, age: Int) {
        self.faculty = faculty
        super.init(name: name, age: age)
    }
}

struct University {
    var name: String
    var location: String
}
