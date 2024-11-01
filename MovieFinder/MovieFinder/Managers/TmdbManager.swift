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
            "query": text,
            "include_adult": "false",
            "language": "fr",
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
    
    func getMovieGenres() async throws -> [Genre] {
        let url = "https://api.themoviedb.org/3/genre/movie/list"
        
        let queryParams: [String: String] = [
            "language": "en"
        ]
        
        let response = try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: GenreResponseModel.self
        )
        
        return response.genres
    }
    
    func getTvGenres() async throws -> [Genre] {
        let url = "https://api.themoviedb.org/3/genre/tv/list"
        
        let queryParams: [String: String] = [
            "language": "en"
        ]
        
        let response = try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: GenreResponseModel.self
        )
        
        return response.genres
    }
    
    func getMediaById(media: Result) async throws -> MediaDetailResponseModel {
        let url: String = {
            switch media.mediaType {
            case .tv:
                return "https://api.themoviedb.org/3/tv/\(media.id)"
            default:
                return "https://api.themoviedb.org/3/movie/\(media.id)"
            }
        }()
        
        let queryParams: [String: String] = [
            "language": "fr"
        ]
        
        let response = try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: MediaDetailResponseModel.self
        )
        
        return response
    }
    
    func getMediaCreditsById(media: Result) async throws -> MediaCreditsResponseModel {
        let url: String = {
            switch media.mediaType {
            case .tv:
                return "https://api.themoviedb.org/3/tv/\(media.id)/aggregate_credits"
            default:
                return "https://api.themoviedb.org/3/movie/\(media.id)/credits"
            }
        }()
        
        let queryParams: [String: String] = [
            "language": "fr"
        ]
        
        let response = try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: MediaCreditsResponseModel.self
        )
        
        return response
    }
    
    func getMediaRecomemndationById(media: Result) async throws -> HomeImageResponseModel {
        let url: String = {
            switch media.mediaType {
            case .tv:
                return "https://api.themoviedb.org/3/tv/\(media.id)/recommendations"
            default:
                return "https://api.themoviedb.org/3/movie/\(media.id)/recommendations"
            }
        }()
        
        let queryParams: [String: String] = [
            "language": "fr"
        ]
        
        let response = try await NetworkService.shared.request(
            urlString: url,
            method: .get,
            headers: ["Authorization": "Bearer \(Bundle.main.apiKey)"],
            queryParams: queryParams,
            responseType: HomeImageResponseModel.self
        )
        
        return response
    }
}
