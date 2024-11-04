//
//  HomeImageResponseModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 26/10/2024.
//

import Foundation

// MARK: - HomeImageResponseModel
struct HomeImageResponseModel: Codable {
    let results: [MediaDetailResponseModel]
}

//// MARK: - Result
//struct MediaDetailResponseModel: Codable {
//    let backdropPath: String?
//    let id: Int
//    let posterPath: String?
//    let name, title, originalTitle, originalName: String?
//    let mediaType: MediaType
//    let genreIds: [Int]?
//    let releaseDate: String?
//    let voteAverage: Double?
//    let firstAirDate: String?
//    
//    var nameOrTitle: String {
//        return originalTitle ?? originalName ?? ""
//    }
//    
//    var date: String {
//        return releaseDate ?? firstAirDate ?? ""
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case backdropPath = "backdrop_path"
//        case id
//        case posterPath = "poster_path"
//        case name
//        case title
//        case originalTitle = "original_title"
//        case mediaType = "media_type"
//        case genreIds = "genre_ids"
//        case releaseDate = "release_date"
//        case voteAverage = "vote_average"
//        case originalName = "original_name"
//        case firstAirDate = "first_air_date"
//    }
//}
//
//enum MediaType: String, Codable {
//    case movie
//    case person
//    case tv
//}
