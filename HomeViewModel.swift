import UIKit

protocol HomeViewModelDelegate {
    
}

class HomeViewModel {
    
    var coordinator: Coordinator?
    var delegate: HomeViewModelDelegate?
    
}
