
import Foundation

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    
    private init(){}
    
    private let urlSession = URLSession.shared
    
    private (set) var authToken: String? {
        get {
            return OAuth2TokenStorage.shared.token
        }
        set {
            OAuth2TokenStorage.shared.token = newValue
        }
    }
    
//    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
//        let request = authTokenRequest(code: code)
//        let task = object(for: request) {[weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let body):
//                let authToken = body.accessToken
//                self.authToken = authToken
//                completion(.success(authToken))
//                
//            case .failure(let error):
//                completion(.failure(error))
    func fetchOAuthToken(with code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let request = authTokenRequest(code: code) else {
            let error = NSError(domain: "OAuth2Service", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create URL request"])
            print("Error creating URL request: \(error.localizedDescription)")
            completion(.failure(NetworkError.urlRequestError(error)))
            return
        }
 
        // Используем расширение URLSession для выполнения запроса и обработки данных
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("URL session error: \(error.localizedDescription)")
                completion(.failure(NetworkError.urlSessionError))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("Failed to receive valid data or response")
                completion(.failure(NetworkError.urlSessionError))
                return
            }

            if 200 ..< 300 ~= response.statusCode {
                do {
                    let decodedResponse = try JSONDecoder().decode(OAuthTokenBody.self, from: data)
                    let accessToken = decodedResponse.accessToken
                    OAuth2TokenStorage.shared.token = accessToken
                    DispatchQueue.main.async {      // вызов блока completion
                        completion(.success(accessToken))
                    }
                } catch {
                    print("Error decoding JSON response: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            } else {
                print("HTTP status code error: \(response.statusCode)")
                completion(.failure(NetworkError.httpStatusCode(response.statusCode)))
            }
        }
        task.resume()
    }
}

private extension OAuth2Service {
    
    private func object(for request: URLRequest, completion: @escaping (Result<OAuthTokenBody, Error>) -> Void) -> URLSessionTask {
        let decoder = JSONDecoder()
        return urlSession.data(for: request) { (result: Result<Data, Error>) in
            let response = result.flatMap {data -> Result<OAuthTokenBody, Error> in
                Result { try decoder.decode(OAuthTokenBody.self, from: data) }
            }
            completion(response)
        }
    }
    
    private func authTokenRequest(code: String) -> URLRequest? {
        guard let baseURL = URL(string: "https://unsplash.com") else {
            fatalError("Base URL could not be initialized")
        }

        let path = "/oauth/token"
            + "?client_id=\(Constants.AccessKey)"
            + "&&client_secret=\(Constants.SecretKey)"
            + "&&redirect_uri=\(Constants.RedirectURL)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code"

        return URLRequest.makeHTTPRequest(path: path, httpMethod: "POST", baseURL: baseURL)
    }
}
