import Foundation
@testable import MoneyBox

class UserDefaultsMock: UserDefaults {
    func setUserAsNil() {
        removeObject(forKey: "User")
    }
}
