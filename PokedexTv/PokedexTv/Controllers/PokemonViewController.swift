//
//  PokemonViewController.swift
//  PokedexTv
//
//  Created by Benjamin_Budet on 08/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit
import SDWebImage

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokedexCollectionView: UICollectionView!
    
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexCollectionView.delegate = self
        pokedexCollectionView.dataSource = self
        GetPokemons(completed: self.updateUI)
        // Do any additional setup after loading the view.
    }

    func updateUI(pokemonsData: [Pokemon]) {
        pokemons = pokemonsData
        pokedexCollectionView.reloadData()
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var indexPath = IndexPath(row: 0, section: 0)
        let cell = sender as! UICollectionViewCell
        indexPath = pokedexCollectionView.indexPath(for: cell) ?? IndexPath(row: 0, section: 0)
        if segue.identifier == "pokemonDetail" {
            if let vc = segue.destination as? PokemonDetailViewController {
                vc.pokemon = pokemons[indexPath.row]
                vc.PokemonId = pokemons[indexPath.row].id
            }
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension PokemonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! PokemonCollectionViewCell
        cell.pokemonImage.sd_setImage(with: URL(string: "http://pokedex-mti.twitchytv.live/images/\(indexPath.row + 1).png"), placeholderImage: UIImage(named: "pokeball"))
        cell.pokemonName.text = pokemons[indexPath.row].name
        cell.pokemonName.isHidden = true
        cell.pokemonType1.backgroundColor = getColorFromType(type: pokemons[indexPath.row].type1.id)
        cell.pokemonType1.text = pokemons[indexPath.row].type1.name
        cell.pokemonType1.layer.cornerRadius = cell.pokemonType1.frame.size.height / 2
        cell.pokemonType1.clipsToBounds = true
        cell.pokemonType1.textColor = UIColor.white
        cell.layer.cornerRadius = 10
        
        if let type2 = pokemons[indexPath.row].type2 {
            cell.pokemonType2.backgroundColor = getColorFromType(type: type2.id)
            cell.pokemonType2.text = type2.name
            cell.pokemonType2.layer.cornerRadius = cell.pokemonType2.frame.size.height / 2
            cell.pokemonType2.clipsToBounds = true
            cell.pokemonType2.textColor = UIColor.white
        } else {
            cell.pokemonType2.text = ""
            cell.pokemonType2.backgroundColor = UIColor.white
        }
        cell.pokemonType1.isHidden = true
        cell.pokemonType2.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
    func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedView != nil) {
            coordinator.addCoordinatedAnimations({() -> Void in
                context.nextFocusedView!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }, completion: nil)
        }
        if (context.previouslyFocusedView != nil) {
            coordinator.addCoordinatedAnimations({() -> Void in
                context.previouslyFocusedView!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
}
