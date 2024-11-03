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
        let response = try await NetworkService.shared.request(
            urlString: Const.Url.homeImages,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            responseType: HomeImageResponseModel.self
        )

        bgImagesHome = response.results.compactMap { $0.backdropPath }
        return bgImagesHome
    }
    
    func getSuggestions(text: String) async throws -> [Result] {
        let queryParams: [String: String] = [
            "query": text,
            "include_adult": "false",
            "language": "fr-FR",
            "page": "1"
        ]
        
        let response = try await NetworkService.shared.request(
            urlString: Const.Url.suggestions,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: HomeImageResponseModel.self
        )
        
        return response.results
    }
    
    func getMovieGenres() async throws -> [Genre] {
        let queryParams: [String: String] = [
            "language": "fr-FR"
        ]
        
        let response = try await NetworkService.shared.request(
            urlString: Const.Url.movieGenres,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: GenreResponseModel.self
        )
        
        return response.genres
    }
    
    func getTvGenres() async throws -> [Genre] {
        let queryParams: [String: String] = [
            "language": "fr-FR"
        ]
        
        let response = try await NetworkService.shared.request(
            urlString: Const.Url.tvGenres,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: GenreResponseModel.self
        )
        
        return response.genres
    }
    
    func getMediaById(media: Result) async throws -> MediaDetailResponseModel {
        let url = Const.Url.mediaById(mediaType: media.mediaType, id: media.id)
        
        let queryParams: [String: String] = [
            "language": "fr-FR"
        ]
        
        return try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: MediaDetailResponseModel.self
        )
    }
    
    func getMediaCreditsById(media: Result) async throws -> MediaCreditsResponseModel {
        let url = Const.Url.mediaCredits(mediaType: media.mediaType, id: media.id)
        
        let queryParams: [String: String] = [
            "language": "fr-FR"
        ]
        
        return try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: MediaCreditsResponseModel.self
        )
    }
    
    func getMediaRecomemndationById(media: Result) async throws -> HomeImageResponseModel {
        let url = Const.Url.mediaRecommendations(mediaType: media.mediaType, id: media.id)
        
        let queryParams: [String: String] = [
            "language": "fr-FR"
        ]
        
        return try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: HomeImageResponseModel.self
        )
    }
}
