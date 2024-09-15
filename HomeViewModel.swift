import UIKit


class HomeViewModel {
    
    var coordinator: Coordinator?
    
    var greetingTitle: String {
        if let name = UserDefaults.standard.getUser()?.firstName {
            return "Hello \(name)!"
        } else {
            return "Hello!"
        }
    }
    
    func logout() {
        coordinator?.finish()
    }
    
}
