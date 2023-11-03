//
//  PokemonViewController.swift
//  Digimon(Pokemon)
//
//  Created by Tony Lieu on 11/2/23.
//

import UIKit

class PokemonViewController : UIViewController {
    var name = String()
    var lvl = String()
    var pokeImg = String()
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonLevelLabel: UILabel!
    @IBOutlet weak var PokemonPic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonNameLabel.text = name
        pokemonLevelLabel.text = lvl
        PokemonPic.toImage(urlString: pokeImg)
        print(pokeImg)
    }
}
