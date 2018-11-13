//
//  PokemonSpecies.swift
//  Pokédex
//
//  Created by Benjamin_Budet on 13/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

public struct PokemonSpecies: Codable {
    public var id: Int
    public var name: String
    public var pokedexNumber: Int
    public var type1: PokemonType
    public var type2: PokemonType?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pokedexNumber = "pokedex_number"
        case type1
        case type2
    }
}
