import Networking

class DataProviderLogicMock: DataProviderLogic {
    func login(request: Networking.LoginRequest, completion: @escaping ((Result<Networking.LoginResponse, any Error>) -> Void)) {
        return
    }
    
    func fetchProducts(completion: @escaping ((Result<Networking.AccountResponse, any Error>) -> Void)) {
        return
    }
    
    func addMoney(request: Networking.OneOffPaymentRequest, completion: @escaping ((Result<Networking.OneOffPaymentResponse, any Error>) -> Void)) {
        return
    }
}
