//
//  PokeResponse.swift
//  PokeWeather
//
//  Created by Juliana Pereira Machado on 23/02/21.
//

import Foundation



struct Species: Codable {
    let name: String
}

struct Sprites: Codable {
    let other: Other
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable{
    let front_default: String
}

struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}

struct PokeResponse: Codable {
    let species: Species
    let sprites: Sprites
    let types: [Types]
    let weight: Int
}


