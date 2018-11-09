//
//  Pokemon.swift
//  Pokédex
//
//  Created by Benjamin_Budet on 25/10/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

public struct Pokemon: Codable {
    public var id: Int
    public var name: String
    public var pokedexNumber: Int
    public var height: String
    public var weight: String
    public var description: String
    public var preEvolutionId: Int?
    public var type1: PokemonType
    public var type2: PokemonType?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pokedexNumber = "pokedex_number"
        case height
        case weight
        case description
        case preEvolutionId = "pre_evolution_id"
        case type1
        case type2
    }    
}
