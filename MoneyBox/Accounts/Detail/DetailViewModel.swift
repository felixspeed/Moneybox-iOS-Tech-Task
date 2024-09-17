import Networking

class DetailViewModel {
    
    var coordinator: DetailCoordinator?
    var viewDelegate: DetailViewControllerDelegate?
    var dataProvider: DataProviderLogic
    
    
    var account: ProductResponse
    
    init(account: ProductResponse) {
        self.account = account
        dataProvider = DataProvider()
    }
    
    func addMoney() {
        guard let productId = account.id else { return  }
        viewDelegate?.loading(true)
        viewDelegate?.addMoneyEnabled(false)
        let request = OneOffPaymentRequest(amount: 10, investorProductID: productId)
        dataProvider.addMoney(request: request) { result in
            switch result {
            case .success:
                self.addSuccessful()
            case .failure(let failure):
                // TODO: Handle failure and display to user through delegate
                print("Money add fail")
                self.viewDelegate?.loading(false)
                self.viewDelegate?.addMoneyEnabled(true)
            }
        }
    }
    
    private func addSuccessful() {
        viewDelegate?.loading(true)
        dataProvider.fetchProducts { result in
            switch result {
            case .success(let success):
                self.updateAccount(success)
            case .failure(let failure):
                // TODO: Handle account get error
                print("Failed to retrieve accounts")
                self.viewDelegate?.loading(false)
                self.viewDelegate?.addMoneyEnabled(true)
            }
        }
    }
    
    private func updateAccount(_ accountResponse: AccountResponse) {
        guard let productResponse = accountResponse.productResponses?.first(where: { $0.id == account.id }) else { return }
        account = productResponse
        print(productResponse)
        viewDelegate?.updateMoneyboxValue("Moneybox: \(productResponse.moneybox?.description.asCurrency ?? "n/a")")
        viewDelegate?.loading(false)
        viewDelegate?.addMoneyEnabled(true)
    }
}
