//
//  ProfileService.swift
//  setupProject
//
//  Created by Илья Дышлюк on 31.05.2024.
//

import Foundation
import UIKit

final class ProfileService {
    
    static let shared = ProfileService()
    private init() {}
    
//    struct ProfileService: Codable{
//        let id: String
//        let updated_at: String
//        let username: String
//        let first_name: String
//        let last_name: String
//        let twitter_username: String
//        let portfolio_url: URL?
//        let bio: String
//        let location: String
//        let total_likes: Int
//        let total_photos: Int
//        let total_collections: Int
//        let followed_by_user: Bool
//        let downloads: Int
//    }
    
    struct Profile {
        let username: String
        let name: String
        let loginName: String
        let bio: String
    }
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        
    }
    
    
}

//private extension ProfileService {
//    func profileRequest(token: String) -> URLRequest {
//        guard let url = URL(
//            string: "\(KeyAndUrl.defaultBaseApiUrl)"
//            + "/me")
//        else {
//            fatalError("Failed to create URL")
//        }
//        var request = URLRequest(url: url)
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        return request
//    }
//}
