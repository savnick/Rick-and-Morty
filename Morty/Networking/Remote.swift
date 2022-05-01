//
//  Remote.swift
//  RickAndMorty
//
//  Created by Nick on 21.02.2022.
//

import SwiftUI

enum NetworkHandlerError: Error {
    case invalidURL
    case invalidResponse(error: ErrorMessage)
    case invalidData
    case apiError
    case decodingError
}

struct ErrorMessage: Codable {
    let error: String
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

final class Remote<A: Decodable> {
    func performAPIRequestByURL(url: String, completed: @escaping (Result<A, NetworkHandlerError>) -> Void)  {
        
        guard let url = URL(string: url) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let _ = error {
                    completed(.failure(.apiError))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.invalidResponse(error: ErrorMessage(error: "Invalid Response"))))
                    return
                }

                guard let data = data else {
                    completed(.failure(.invalidData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(A.self, from: data)
                    completed(.success(decodedResponse))
                    
                } catch {
                    completed(.failure(.invalidData))
                }
        }
        
        task.resume()
    }
    
}
