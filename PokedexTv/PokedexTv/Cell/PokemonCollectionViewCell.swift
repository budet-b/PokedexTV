//
//  PokemonCollectionViewCell.swift
//  PokedexTv
//
//  Created by Benjamin_Budet on 08/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonType1: UILabel!
    @IBOutlet weak var pokemonType2: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        pokemonName.isHidden = !self.isFocused
        pokemonType1.isHidden = !self.isFocused
        pokemonType2.isHidden = !self.isFocused
        
    }
}
