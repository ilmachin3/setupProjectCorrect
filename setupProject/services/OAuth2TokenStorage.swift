//
//  OAuth2TokenStorage.swift
//  setupProject
//
//  Created by Илья Дышлюк on 02.05.2024.
//

import Foundation

final class OAuth2TokenStorage {
    
    static let shared = OAuth2TokenStorage()
    private let bearerTokenKey = "OAuth2BearerToken"
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: bearerTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: bearerTokenKey)
        }
    }
}
