//
//  PokemonCellView.swift
//  PokedexTv
//
//  Created by Benjamin_Budet on 09/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class PokemonCellView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func canBecomeFocused() -> Bool {
        return true
    }

    func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        //Bahavior we will trigger when view lost focus
        if context.previouslyFocusedView === self
        {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                context.previouslyFocusedView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
        
        //Bahavior we will trigger when view get focus
        if context.nextFocusedView === self
        {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                context.nextFocusedView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
        
    }
}
