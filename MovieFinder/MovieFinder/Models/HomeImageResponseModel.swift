//
//  HomeImageResponseModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 26/10/2024.
//

import Foundation

// MARK: - HomeImageResponseModel
struct HomeImageResponseModel: Codable {
//    let page: Int
    let results: [Result]
//    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
//        case page, 
        case results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let backdropPath: String?
    let id: Int
    let posterPath: String?
    let name, title, originalTitle, originalName: String?
//    let title, originalTitle: String?
//    let overview, posterPath: String
    let mediaType: MediaType
//    let adult: Bool
//    let originalLanguage: String
    let genreIds: [Int]?
//    let popularity: Double?
    let releaseDate: String?
//    let video: Bool?
    let voteAverage: Double?
//    let voteCount: Int
    let firstAirDate: String?
//    let originCountry: [String]?
    
    var nameOrTitle: String {
//        return name ?? title ?? ""
        return originalTitle ?? originalName ?? ""
    }
    
    var date: String {
        return releaseDate ?? firstAirDate ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case posterPath = "poster_path"
        case name
        case title
        case originalTitle = "original_title"
//        case overview
//        case posterPath = "poster_path"
        case mediaType = "media_type"
//        case adult
//        case originalLanguage = "original_language"
        case genreIds = "genre_ids"
//        case popularity
        case releaseDate = "release_date"
//        case video
        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
//        case originCountry = "origin_country"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}
