//
//  GenreResponseModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 30/10/2024.
//

import Foundation

// MARK: - GenreResponseModel
struct GenreResponseModel: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
