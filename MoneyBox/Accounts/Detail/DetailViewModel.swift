import Networking
import UIKit

class DetailViewModel {
    
    var coordinator: DetailCoordinator?
    var viewDelegate: DetailViewControllerDelegate?
    var dataProvider: DataProviderLogic
    
    
    var product: ProductResponse
    
    convenience init(product: ProductResponse) {
        self.init(product: product,
                  dataProvider: DataProvider())
    }
    
    init(product: ProductResponse, dataProvider: DataProviderLogic) {
        self.product = product
        self.dataProvider = dataProvider
    }
    
    func getInfo() -> [(String, String)] {
        return [("first", "number"), ("second", "yahoo")]
    }
    
    func addMoney() {
        guard let productId = product.id else { return  }
        viewDelegate?.loading(true)
        viewDelegate?.addMoneyEnabled(false)
        let request = OneOffPaymentRequest(amount: 10, investorProductID: productId)
        dataProvider.addMoney(request: request) { result in
            switch result {
            case .success:
                self.addSuccessful()
            case .failure(let failure):
                self.viewDelegate?.showError(failure.localizedDescription)
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
                self.viewDelegate?.showError(failure.localizedDescription)
                self.viewDelegate?.loading(false)
                self.viewDelegate?.addMoneyEnabled(true)
            }
        }
    }
    
    private func updateAccount(_ accountResponse: AccountResponse) {
        guard let productResponse = accountResponse.productResponses?.first(where: { $0.id == product.id }) else { return }
        product = productResponse
        print(productResponse)
        viewDelegate?.updateMoneyboxValue("Moneybox: \(productResponse.moneybox?.description.asCurrency ?? "n/a")")
        viewDelegate?.loading(false)
        viewDelegate?.addMoneyEnabled(true)
    }
}
