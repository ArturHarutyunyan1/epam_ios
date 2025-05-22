import UIKit

struct School {
    enum SchoolRole {
        case student, teacher, administrator
    }
    
    class Person {
        let name: String
        let role: SchoolRole
        
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }
    
    private var people: [Person] = []
    
    subscript(_ role: SchoolRole) -> [Person] {
        return people.filter {$0.role == role}
    }
    
    mutating func addPerson(_ name: String, _ role: SchoolRole) {
        people.append(Person(name: name, role: role))
    }
}

func countStudents(_ school: School) -> Int {
    return school[.student].count
}
func countTeachers(_ school: School) -> Int {
    return school[.teacher].count
}
func countAdministrators(_ school: School) -> Int {
    return school[.administrator].count
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
//print(countTeachers(mySchool))
