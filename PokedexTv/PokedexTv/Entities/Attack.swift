//
//  Attack.swift
//  Pokédex
//
//  Created by Benjamin_Budet on 13/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation
public struct Attack: Codable {
    public var id: Int
    public var name: String
    public var type: PokemonType
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
    }
}
