//
//  Type.swift
//  Pokédex
//
//  Created by Benjamin_Budet on 25/10/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

public struct PokemonType: Codable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
