import XCTest
import Networking

@testable import MoneyBox

final class DetailViewModelTests: XCTestCase {
    private var viewDelegate: DetailViewControllerDelegateMock!
    
    private var dataProvider: DataProviderLogicMock!
    
    private var detailViewModel: DetailViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewDelegate = DetailViewControllerDelegateMock()
        dataProvider = DataProviderLogicMock()
        
        var product: ProductResponse!
        StubData.read(file: "Accounts") { (result: Result<AccountResponse, any Error>) in
            switch result {
            case .success(let success):
                product = success.productResponses?.first
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        detailViewModel = DetailViewModel(product: product, dataProvider: dataProvider)
        detailViewModel.viewDelegate = viewDelegate
    }
    
    func test_DetailViewModel_addMoney_success() throws {
        StubData.read(file: "OneOffPaymentResponse") { (result: Result<OneOffPaymentResponse, any Error>) in
            switch result {
            case .success(let success):
                self.dataProvider.addMoneyResponse = .success(success)
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        StubData.read(file: "Accounts") { (result: Result<AccountResponse, any Error>) in
            switch result {
            case .success(let success):
                self.dataProvider.fetchProductsResponse = .success(success)
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        detailViewModel.addMoney()
        
        XCTAssertNil(viewDelegate.errorMessage)
        XCTAssertNotNil(detailViewModel.product)
    }
    
    func test_DetailViewModel_addMoney_success_updatesMoneyboxValue() throws {
        StubData.read(file: "OneOffPaymentResponse") { (result: Result<OneOffPaymentResponse, any Error>) in
            switch result {
            case .success(let success):
                self.dataProvider.addMoneyResponse = .success(success)
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        var moneyboxValue: String!
        StubData.read(file: "Accounts") { (result: Result<AccountResponse, any Error>) in
            switch result {
            case .success(let success):
                if let productResponse = success.productResponses?.first(where: { $0.id == self.detailViewModel.product.id }) {
                    moneyboxValue = "Moneybox: \(productResponse.moneybox?.description.asCurrency ?? "n/a")"
                    self.dataProvider.fetchProductsResponse = .success(success)
                } else {
                    XCTFail("Error retrieving product with id: \(self.detailViewModel.product.id ?? 0)")
                    return
                }
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        
        
        detailViewModel.addMoney()
        
        XCTAssertNil(viewDelegate.errorMessage)
        XCTAssertEqual(viewDelegate.moneyBoxValue, moneyboxValue)
    }
    
    func test_DetailViewModel_addMoney_failure_addMoneyApiCallFailure() throws {
        dataProvider.addMoneyResponse = .failure(MockError.apiCallFailure)
        
        detailViewModel.addMoney()
        
        XCTAssertEqual(viewDelegate.errorMessage, MockError.apiCallFailure.localizedDescription)
    }
    
    func test_DetailViewModel_addMoney_failure_fetchAccountsApiCallFailure() throws {
        StubData.read(file: "OneOffPaymentResponse") { (result: Result<OneOffPaymentResponse, any Error>) in
            switch result {
            case .success(let success):
                self.dataProvider.addMoneyResponse = .success(success)
            case .failure(let failure):
                XCTFail("Error reading StubData: \(failure.localizedDescription)")
            }
        }
        
        dataProvider.fetchProductsResponse = .failure(MockError.apiCallFailure)
        
        detailViewModel.addMoney()
        
        
    }
}

class DetailViewControllerDelegateMock: DetailViewControllerDelegate {
    var moneyBoxValue: String?
    var errorMessage: String?
    
    func loading(_ state: Bool) {}
    
    func addMoneyEnabled(_ state: Bool) {}
    
    func updateMoneyboxValue(_ value: String) {
        moneyBoxValue = value
    }
    
    func showError(_ error: String) {
        errorMessage = error
    }
    
    
}
