//
//  OAuthToken..swift
//  setupProject
//
//  Created by Илья Дышлюк on 02.05.2024.
//

import Foundation

enum OAuthRequestError: Error {
    case urlComponentError
    case urlCreationError
    case duplicateRequest
    case urlRequestError(Error)
    case decodingError(Error)
    case urlSessionError(Error)
    case invalidResponse(Int)
    case invalidData
}

enum AuthServiceError: Error {
    case invalidRequest
}

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    private init() {}
    
    private var task: URLSessionTask?
    private var lastCode: String?
    private let urlSession = URLSession.shared
    

    
    func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard let baseURL = URL(string: "https://unsplash.com/oauth/token"),
              var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            let urlComponentsError = OAuthRequestError.urlComponentError
            print("[makeOAuthTokenRequest]: OAuthRequestError - \(urlComponentsError)")
            return nil
        }
        
        let queryItems = [
            URLQueryItem(name: "client_id", value: Constants.AccessKey),
            URLQueryItem(name: "client_secret", value: Constants.SecretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.RedirectURL),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        components.queryItems = queryItems
        
        guard let url = components.url else {
            let urlError = OAuthRequestError.urlCreationError
            print("[makeOAuthTokenRequest]: OAuthRequestError \(urlError)")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
}
