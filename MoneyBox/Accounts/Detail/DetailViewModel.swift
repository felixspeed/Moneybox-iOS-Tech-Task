import Networking

class DetailViewModel {
    
    var coordinator: DetailCoordinator?
    
    var account: ProductResponse
    
    init(account: ProductResponse) {
        self.account = account
    }
    
}
