import UIKit


class HomeViewModel {
    
    var coordinator: Coordinator?
    
    func logout() {
        coordinator?.finish()
    }
    
}
