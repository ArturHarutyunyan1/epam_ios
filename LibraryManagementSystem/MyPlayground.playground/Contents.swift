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
        if let returnDate = returnDate {
            return Date() > returnDate
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
    var id: String
    var title: String
    var author: String
    
    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
    
}

class Book : Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool = false
}

class Library {
    var items: [String : Item] = [:]
    
    func addBook(_ book: Book) {
        let id = UUID().uuidString
        book.id = id
        items[id] = book
    }
    func borrowItem(by id: String) throws -> Item {
        guard let item = items[id] as? Book else {
            throw LibraryError.itemNotFound
        }
        guard let borrowableItem = items[id] as? Borrowable else {
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
//let book1 = Book(id: "124", title: "Harry Potter and the Chamber of Secrets", author: "Kanye West")
//
//library.addBook(book1)
//
//do {
//    try library.borrowItem(by: book1.id)
//    print("Successfully borrowed the book \(book1.title)")
//    try library.borrowItem(by: book1.id)
//} catch LibraryError.alreadyBorrowed {
//    print("Error: \(book1.title) is already borrowed")
//} catch LibraryError.itemNotBorrowable {
//    print("Error: \(book1.title) is not borrowable")
//} catch LibraryError.itemNotFound {
//    print("Error: \(book1.title) was not found")
//} catch {
//    print("Error: Uncaught exception")
//}
