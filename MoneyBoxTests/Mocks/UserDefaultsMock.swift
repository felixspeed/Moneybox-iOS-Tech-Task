import Foundation
@testable import MoneyBox

// It would be better if your mock didn't depend on user defaults. This could cause
// flakey unit tests if the test suite is running in parallel
class UserDefaultsMock: UserDefaults {
    func setUserAsNil() {
        removeObject(forKey: "User")
    }
}
