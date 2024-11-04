//
//  ProfileService.swift
//  setupProject
//
//  Created by Илья Дышлюк on 31.05.2024.
//

import Foundation
import UIKit

enum ProfileServiceError: Error {
    case invalidURL
    case urlRequestError(Error)
    case urlSessionError
}

final class ProfileService {
    
    private(set) var profile: Profile?
    static let shared = ProfileService()
    private init() {}
    
    private var task: URLSessionTask?
    
    struct ProfileResult: Codable {
        let id: String
        let updated_at: String
        let username: String
        let first_name: String
        let last_name: String
        let twitter_username: String
        let portfolio_url: URL?
        let bio: String
        let location: String
        let total_likes: Int
        let total_photos: Int
        let total_collections: Int
        let followed_by_user: Bool
        let downloads: Int
    }
    
    struct Profile {
        let username: String
        let name: String
        let loginName: String
        let bio: String
    }
    
    private func makeUrlRequest(endpoint: String, bearerToken: String) -> URLRequest? {
        guard let url = URL(string: endpoint) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        return request
        
    }
    
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        guard let request = makeUrlRequest(endpoint: "https://api.unsplash.com/me", bearerToken: token) else {
            let urlRequestError = ProfileServiceError.invalidURL
            print("[fetchProfile]: Profile Service Error - \(urlRequestError)")
            completion(.failure(urlRequestError))
            return
        }
        
        if let task = self.task {
            task .cancel()
        }
        
        let session = URLSession.shared
        let task = session.objectTask(for: request) { (result: Result<ProfileResult, Error>) in
            switch result {
            case.success(let profileResult):
                let profile = Profile(
                    username: profileResult.username,
                    name: "\(profileResult.first_name ?? "") \(profileResult.last_name ?? "")".trimmingCharacters(in: .whitespacesAndNewlines),
                    loginName: "@\(profileResult.username)",
                    bio: profileResult.bio)
                self.profile = profile
                completion(.success(profile))
            case.failure(_):
                let invalidSessionError = ProfileServiceError.urlSessionError
                print("[objectTask]: Profile Service Error - \(invalidSessionError)")
                completion(.failure(invalidSessionError))
            }
        }
        task.resume()
        self.task = task
    }
}
