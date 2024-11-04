//
//  MediaDetailResponseModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 31/10/2024.
//

import Foundation

// MARK: - MediaDetailResponseModel
struct MediaDetailResponseModel: Codable {
    let backdropPath: String?
    let firstAirDate, releaseDate: String?
    let genres: [Genre]?
    let genreIds: [Int]?
    let homepage: String?
    let id: Int
    let numberOfEpisodes, numberOfSeasons: Int?
    let originalName, originalTitle: String?
    let overview: String?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    var mediaType: MediaType?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case releaseDate = "release_date"
        case genres, homepage, id
        case genreIds = "genre_ids"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
    }
    
    var date: String? {
        return releaseDate ?? firstAirDate ?? nil
    }
    
    var nameOrTitle: String {
        return originalName ?? originalTitle ?? ""
    }
    
    var typeMedia: MediaType {
        return mediaType ?? .person
    }
}

enum MediaType: String, Codable {
    case movie
    case person
    case tv
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = MediaType(rawValue: rawValue) ?? .person
    }
}
