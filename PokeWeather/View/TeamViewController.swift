//
//  TeamViewController.swift
//  PokeWeather
//
//  Created by Beatriz da Silva on 01/03/21.
//

import UIKit

class TeamViewController: UIViewController {
    @IBOutlet weak var PokemonCard: TeamPokemonView!
    
    @IBOutlet weak var firstPokemonMiniature: UIImageView!
    @IBOutlet weak var secondPokemonMiniature: UIImageView!
    @IBOutlet weak var thirdPokemonMiniature: UIImageView!
    
    @IBOutlet weak var firstPokemonArrow: UIImageView!
    @IBOutlet weak var secondPokemonArrow: UIImageView!
    @IBOutlet weak var thirdPokemonArrow: UIImageView!
    
    @IBOutlet weak var shareYourTeam: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokemonCard.layer.cornerRadius = PokemonCard.frame.height / 2
    }

}
