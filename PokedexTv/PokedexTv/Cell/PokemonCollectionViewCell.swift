//
//  PokemonCollectionViewCell.swift
//  PokedexTv
//
//  Created by Benjamin_Budet on 08/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonView:UIView!

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonType1: UILabel!
    @IBOutlet weak var pokemonType2: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    
    let originalImageSize = CGSize(width: 100, height: 100)
    let focusedImageSize = CGSize(width: 120, height: 120)
    
    override var canBecomeFocused : Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        pokemonView.didUpdateFocus(in: context, with: coordinator)
        pokemonName.isHidden = !self.isFocused
        pokemonType1.isHidden = !self.isFocused
        pokemonType2.isHidden = !self.isFocused
        if context.nextFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.layer.backgroundColor = UIColor.blue.withAlphaComponent(0.2).cgColor
            }, completion: nil)
            self.pokemonImage.adjustsImageWhenAncestorFocused = true
            self.pokemonView.frame.size = CGSize(width: self.pokemonView.frame.width + 200, height: self.pokemonView.frame.height + 200)
            self.setNeedsFocusUpdate()
            self.updateFocusIfNeeded()
        } else if context.previouslyFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.layer.backgroundColor = UIColor.clear.cgColor
            }, completion: nil)
            self.pokemonImage.adjustsImageWhenAncestorFocused = false
            self.pokemonView.frame.size = CGSize(width: self.pokemonView.frame.width - 20, height: self.pokemonView.frame.height - 20)
        }
    }
}
