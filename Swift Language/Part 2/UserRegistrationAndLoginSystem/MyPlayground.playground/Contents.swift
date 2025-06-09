import UIKit
import CryptoKit

struct User : Hashable {
    var username: String
    var email: String
    private(set) var password: String
    
    init (username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = User.hash(password: password)
    }
    
    private static func hash(password: String) -> String {
        let data = Data(password.utf8)
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    static func checkPassword(password: String, hashed: String) -> Bool {
        return hashed == User.hash(password: password)
    }
}

class UserManager {
    var users: [String : User] = [:]
    
    func registerUser(username: String, email: String, password: String) -> Bool {
        if users[username] != nil {
            print("User is already registered")
            return false
        }
        if username.count > 0 && email.count > 0 && password.count > 0 {
            let user = User(username: username, email: email, password: password)
            users[username] = user
            print("User was registered successfully")
            return true
        }
        print("Fields can't be empty")
        return false
    }
    
    func login(username: String, password: String) -> Bool {
        guard let user = users[username] else {
            print("Login failed. No such user \(username)")
            return false
        }
        let checkHashed = User.checkPassword(password: password, hashed: user.password)
        if checkHashed {
            print("Login successfull for user \(username)")
            return true
        }
        print("Login failed")
        return false
    }
    func removeUser(username: String) -> Bool {
        if users[username] != nil {
            users[username] = nil
            print("User was removed successfully")
            return true
        }
        print("No such user \(username)")
        return false
    }
    var userCount: Int {
        return users.count
    }
}

class AdminUser : UserManager {
    func listAllUsers() -> [String] {
        var userList: [String] = []
        for (key, value) in users {
            userList.append(key)
        }
        return userList
    }
    deinit {
        print("AdminUser was deinitialized")
    }
}
