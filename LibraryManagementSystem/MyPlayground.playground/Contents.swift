import UIKit

enum LibraryError : Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
}

protocol Borrowable : AnyObject {
    var borrowDate: Date? {get set}
    var returnDate: Date? {get set}
    var isBorrowed: Bool {get set}
    func checkIn()
}

extension Borrowable {
    func isOverdue() -> Bool {
        if let returnDate = returnDate {
            return Date() > returnDate
        }
        return false
    }
    func checkIn() {
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
    }
}

class Item {
    let id: String
    let title: String
    let author: String
    
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
        items[book.id] = book
    }
    func borrowItem(by id: String) throws -> Item {
        guard var borrowableItem = items[id] as? Borrowable else {
            guard items[id] != nil else {
                throw LibraryError.itemNotFound
            }
            throw LibraryError.itemNotBorrowable
        }
        guard let item = items[id] else {
            throw LibraryError.itemNotFound
        }
        if borrowableItem.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }
        borrowableItem.borrowDate = Date()
        borrowableItem.returnDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        borrowableItem.isBorrowed = true
        
        items[id] = borrowableItem as? Item
        return item
    }
}
