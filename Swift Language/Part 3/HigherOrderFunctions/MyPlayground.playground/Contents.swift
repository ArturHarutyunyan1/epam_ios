import UIKit

let books = [
["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
]

var totalCost: Int = 0

let discountedPrices: [Double] = books.compactMap {book in
    guard let price = book["price"] as? Int else { return nil }
    return Double(price) * 0.9
}

let booksPostedAfter2000: [String] = books.filter { book in
    guard let year = book["year"] as? Int else { return false }
    return year > 2000
}.compactMap { $0["title"] as? String }

var allGenres: Set<String> = Set(books.compactMap { $0["genre"] as? [String] }.flatMap { $0 })

totalCost = books.reduce(0) { total, book in
    guard let price = book["price"] as? Int else { return total }
    return total + price
}

print(discountedPrices)
print(booksPostedAfter2000)
print(allGenres)
print(totalCost)
