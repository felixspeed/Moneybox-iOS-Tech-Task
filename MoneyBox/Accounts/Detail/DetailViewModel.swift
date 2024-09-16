import Networking

class DetailViewModel {
    
    var coordinator: DetailCoordinator?
    var dataProvider: DataProviderLogic
    
    
    var account: ProductResponse
    
    init(account: ProductResponse) {
        self.account = account
        dataProvider = DataProvider()
    }
    
    func addMoney() {
        guard let productId = account.id else { return  }
        let request = OneOffPaymentRequest(amount: 10, investorProductID: productId)
        dataProvider.addMoney(request: request) { result in
            switch result {
            case .success:
                print("Money added!")
            case .failure(let failure):
                // TODO: Handle failure and display to user through delegate
                print("Money add fail")
            }
        }
    }
}
