enum LoginError: Error {
    case validationError
    
    var description: String {
        switch self {
        case .validationError:
            "Invalid email address"
        }
    }
}
