//
//  LoginResponse.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import Foundation

// MARK: - LoginResponse
public struct LoginResponse: Decodable {
    public let session: Session
    public let user: User
    
    enum CodingKeys: String, CodingKey {
        case session = "Session"
        case user = "User"
    }
    
    public struct Session: Decodable {
        // Changed to public for token saving within SessionManager
        public let bearerToken: String
        
        enum CodingKeys: String, CodingKey {
            case bearerToken = "BearerToken"
        }
    }
    
    // MARK: - User
    public struct User: Codable {
        public let firstName: String?
        public let lastName: String?
        
        enum CodingKeys: String, CodingKey {
            case firstName = "FirstName"
            case lastName = "LastName"
        }
    }
}
