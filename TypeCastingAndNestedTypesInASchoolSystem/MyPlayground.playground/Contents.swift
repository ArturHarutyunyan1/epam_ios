import UIKit

struct School {
    enum SchoolRole {
        case student, teacher, administrator
    }
    class Person {
        var name: String
        var role: SchoolRole
        
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }
    private var personArray: [Person] = []
    subscript(_ role: SchoolRole) -> [Person] {
        return personArray.filter {$0.role == role}
    }
    mutating func addPerson(_ name: String, _ role: SchoolRole) {
        personArray.append(Person(name: name, role: role))
    }
    static func countStudents(_ school: School) -> Int {
        return school[.student].count
    }
    static func countTeachers(_ school: School) -> Int {
        return school[.teacher].count
    }
    static func countAdministrators(_ school: School) -> Int {
        return school[.administrator].count
    }
}

//var mySchool = School()
//let roles: [School.SchoolRole] = [.administrator, .student, .teacher]
//
//mySchool.addPerson("Kanye West", .administrator)
//mySchool.addPerson("Kanye West1", .administrator)
//mySchool.addPerson("Kanye West2", .administrator)
//mySchool.addPerson("Kanye West3", .administrator)
//
//mySchool.addPerson("Kanye West4", .student)
//mySchool.addPerson("Kanye West5", .student)
//
//mySchool.addPerson("Kanye West6", .teacher)
//mySchool.addPerson("Kanye West7", .teacher)
//mySchool.addPerson("Kanye West8", .teacher)
//mySchool.addPerson("Kanye West9", .teacher)
//mySchool.addPerson("Kanye West10", .teacher)
//
//print(School.countAdministrators(mySchool))
