//
//  Service.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 26/10/2024.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    func request<T: Decodable>(
        urlString: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        queryParams: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        guard var components = URLComponents(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        if let queryParams = queryParams {
            components.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Request error : \(urlString) (\(httpResponse.statusCode))")
            throw NetworkError.invalidResponse
        }
        
        print("Request : \(urlString) (\(httpResponse.statusCode))")
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidParameters
    case invalidResponse
    case noData
    case decodingError
}
