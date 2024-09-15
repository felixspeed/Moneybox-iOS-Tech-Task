import Foundation
import Networking

typealias User = LoginResponse.User

class UserModel  {
    var user: User?
}

protocol UserDefaultsHelper {
    func saveUser(_ user: User)
    func getUser() -> User?
}

extension UserDefaults: UserDefaultsHelper {
    func saveUser(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            self.set(data, forKey: "User")
        } catch {
            print("Error encoding user's data = \(error)")
        }
    }
    
    func getUser() -> User? {
        guard let data = self.data(forKey: "User") else { return nil }
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            print("Error decoding user's data = \(error)")
            return nil
        }
    }
}
