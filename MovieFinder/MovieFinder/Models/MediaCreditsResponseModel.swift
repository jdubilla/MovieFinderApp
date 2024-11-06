//
//  MediaCreditsResponseModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 01/11/2024.
//

import SwiftUI

// MARK: - MediaCreditsResponseModel
struct MediaCreditsResponseModel: Codable {
    let cast: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let id: Int
    let knownForDepartment: KnownForDepartment
    let name, originalName: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case creator = "Creator"
    case directing = "Directing"
    case editing = "Editing"
    case production = "Production"
    case sound = "Sound"
    case writing = "Writing"
    case unknown = "Unknown"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try? container.decode(String.self)
        self = KnownForDepartment(rawValue: value ?? "") ?? .unknown
    }
    
    func localized() -> LocalizedStringKey {
        let mapping: [String: String] = [
            "Acting": "role_actor",
            "Art": "role_art",
            "Camera": "role_camera",
            "Costume & Make-Up": "role_costume_makeup",
            "Creator": "role_creator",
            "Directing": "role_directing",
            "Editing": "role_editing",
            "Production": "role_production",
            "Sound": "role_sound",
            "Writing": "role_writing",
            "Unknown": ""
        ]
        
        let key = mapping[self.rawValue] ?? self.rawValue
        return LocalizedStringKey(key)
    }
}
