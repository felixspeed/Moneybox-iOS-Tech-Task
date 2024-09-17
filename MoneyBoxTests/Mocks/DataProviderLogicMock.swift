import Networking

class DataProviderLogicMock: DataProviderLogic {
    
    var loginResponse: Result<Networking.LoginResponse, any Error>!
    
    func login(request: Networking.LoginRequest, completion: @escaping ((Result<Networking.LoginResponse, any Error>) -> Void)) {
        completion(self.loginResponse)
    }
    
    
    var fetchProductsResponse: Result<Networking.AccountResponse, any Error>!
    
    func fetchProducts(completion: @escaping ((Result<Networking.AccountResponse, any Error>) -> Void)) {
        completion(self.fetchProductsResponse)
    }
    
    
    var addMoneyResponse: Result<Networking.OneOffPaymentResponse, any Error>!
    
    func addMoney(request: Networking.OneOffPaymentRequest, completion: @escaping ((Result<Networking.OneOffPaymentResponse, any Error>) -> Void)) {
        completion(self.addMoneyResponse)
    }
}
