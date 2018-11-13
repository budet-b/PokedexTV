//
//  PokemonArena.swift
//  Pokédex
//
//  Created by Benjamin_Budet on 13/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation
public struct PokemonArena: Codable {
    
    public var nickname: String?
    public var level: Int
    public var shiny: Bool
    public var species: PokemonSpecies
    public var attack1: Attack?
    public var attack2: Attack?
    public var attack3: Attack?
    public var attack4: Attack?
    
    enum CodingKeys: String, CodingKey {
        case level
        case nickname
        case shiny
        case species
        case attack1
        case attack2
        case attack3
        case attack4
    }
}
