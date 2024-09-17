@testable import MoneyBox

class UserDefaultsMock: UserDefaultsHelper {
    func saveUser(_ user: MoneyBox.User) {
        return
    }
    
    func getUser() -> MoneyBox.User? {
        return nil
    }
}
