//
//  TypeResponse.swift
//  PokeWeather
//
//  Created by Kauê Sales on 26/02/21.
//

import Foundation

struct TypeDataResponse: Codable {
    let results: [PokemonTypeData]
}

struct PokemonTypeData: Codable {
    let name: String
    let url: String
}

struct damageResponse: Codable {
    let damage_relations: DamageRelationsData
}

struct DamageRelationsData: Codable {
    let double_damage_from: [WeaknessData]
    let double_damage_to: [StrengthData]
}

struct WeaknessData: Codable {
    let name: String
}

struct StrengthData: Codable {
    let name: String
}


