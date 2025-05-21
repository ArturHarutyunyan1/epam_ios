import UIKit

enum LibraryError : Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
}

protocol Borrowable {
    var borrowDate: Date? {get set}
    var returnDate: Date? {get set}
    var isBorrowed: Bool {get set}
    mutating func checkIn()
}

extension Borrowable {
    func isOverdue() -> Bool {
        if let rDate = self.returnDate {
            return Date() > rDate
        }
        return false
    }
    mutating func checkIn() {
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
    }
}

class Item {
    var id: String?
    var title: String?
    var author: String?
    
}

class Book : Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool = false
}

class Library {
    var books: Dictionary<String, Item> = [:]
    
    func addBook(_ book: Book) {
        let id = UUID().uuidString
        book.id = id
        books[id] = book
    }
    func borrowItem(by id: String) throws -> Item {
        guard let item = books[id] as? Book else {
            throw LibraryError.itemNotFound
        }
        guard let borrowableItem = books[id] as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        if !item.isBorrowed {
            item.borrowDate = Date()
            item.returnDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
            item.isBorrowed = true
        } else {
            throw LibraryError.alreadyBorrowed
        }
        return item
    }
}

//let library = Library()
//var book1 = Book()
//
//book1.title = "Harry Potter and the Chamber of Secrets"
//book1.author = "Kanye West"
//library.addBook(book1)
//
//if var id = book1.id, let title = book1.title {
//    do {
//        try library.borrowItem(by: id)
//        print("Successfully borrowed the book \(title)")
//        try library.borrowItem(by: id)
//    } catch LibraryError.alreadyBorrowed {
//        print("Error: \(title) is already borrowed")
//    } catch LibraryError.itemNotBorrowable {
//        print("Error: \(title) is not borrowable")
//    } catch LibraryError.itemNotFound {
//        print("Error: \(title) was not found")
//    } catch {
//        print("Error: Uncaught exception")
//    }
//}
