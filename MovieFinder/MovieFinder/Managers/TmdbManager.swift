//
//  TmdbManager.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 26/10/2024.
//

import Foundation

class TmdbManager {
    var bgImagesHome: [String] = []
    static let shared = TmdbManager()
    
    func getHomeImages() async throws -> [String] {
        let url = "https://api.themoviedb.org/3/trending/all/day"
        
        let response = try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            responseType: HomeImageResponseModel.self
        )

        bgImagesHome = response.results.compactMap { $0.backdropPath }
        return bgImagesHome
    }
    
    func getSuggestions(text: String) async throws -> [Result] {
        let url = "https://api.themoviedb.org/3/search/multi"
        
        let queryParams: [String: String] = [
//            "query": text,
            "query": "Simpson",
            "include_adult": "false",
            "language": "en-US",
            "page": "1"
        ]
        
        let response = try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: HomeImageResponseModel.self
        )
        
        return response.results
    }
}
