//
//  PokemonDetailViewController.swift
//  PokedexTv
//
//  Created by Benjamin_Budet on 08/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonId: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokemonWidth: UILabel!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var pokemonPreEvolutionImage: UIImageView!
    @IBOutlet weak var pokemonType2: UILabel!
    @IBOutlet weak var pokemonType1: UILabel!
    
    var pokemon: Pokemon?
    var PokemonId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonName.text = pokemon?.name
        pokemonImage.sd_setImage(with: URL(string: "http://pokedex-mti.twitchytv.live/images/\(PokemonId).png"), placeholderImage: UIImage(named: "pokeball"))
        self.title = pokemon?.name
        pokemonId.text = "\(PokemonId)"
        pokemonType1.text = pokemon?.type1.name
        pokemonType2.text = pokemon?.type2?.name ?? ""
        pokemonHeight.text = pokemon?.height
        pokemonWidth.text =  pokemon?.weight
        pokemonDescription.text =  pokemon?.description
        pokemonType1.backgroundColor = getColorFromType(type: pokemon?.type1.id ?? 0)
        pokemonType1.layer.cornerRadius = pokemonType1.frame.size.height / 2
        pokemonType1.clipsToBounds = true
        pokemonType1.textColor = UIColor.white
        
        if let type2 = pokemon?.type2 {
            pokemonType2.backgroundColor = getColorFromType(type: type2.id)
            pokemonType2.text = type2.name
            pokemonType2.layer.cornerRadius = pokemonType2.frame.size.height / 2
            pokemonType2.clipsToBounds = true
            pokemonType2.textColor = UIColor.white
        } else {
            pokemonType2.text = ""
        }
        if let pre_evol = pokemon?.preEvolutionId {
            pokemonPreEvolutionImage.sd_setImage(with: URL(string: "http://pokedex-mti.twitchytv.live/images/\(pre_evol).png"), placeholderImage: UIImage(named: "pokeball"))
        } else {
            pokemonPreEvolutionImage.image = nil
            self.view.layoutIfNeeded()
        }
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
