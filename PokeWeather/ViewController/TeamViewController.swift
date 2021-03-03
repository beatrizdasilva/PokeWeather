//
//  TeamViewController.swift
//  PokeWeather
//
//  Created by Beatriz da Silva on 01/03/21.
//
import UIKit
import CoreData

class TeamViewController: UIViewController {
    // MARK: Variables
    var pokemonIndex = 0
    var pokemonData: [Pokemon]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: Outlets
    @IBAction func btnPrevious(_ sender: Any) {
        decrease()
    }
    @IBAction func btnNext(_ sender: Any) {
        increase()
    }
    @IBOutlet weak var PokemonCard: TeamPokemonView!
    @IBOutlet weak var firstPokemonMiniature: UIImageView!
    @IBOutlet weak var secondPokemonMiniature: UIImageView!
    @IBOutlet weak var thirdPokemonMiniature: UIImageView!
    @IBOutlet weak var firstPokemonArrow: UIImageView!
    @IBOutlet weak var secondPokemonArrow: UIImageView!
    @IBOutlet weak var thirdPokemonArrow: UIImageView!
    @IBOutlet weak var shareYourTeam: UIButton!
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        updateData()
        PokemonCard.layer.cornerRadius = PokemonCard.frame.height / 2
    }
    
    func updateData() {
        PokemonCard.pokemonImage.image = UIImage(data: pokemonData![pokemonIndex].sprite!)
        PokemonCard.pokemonName.text = pokemonData![pokemonIndex].name?.uppercased()
        PokemonCard.pokemonWeight.text = "\(NSString(format: "%.1f", pokemonData![pokemonIndex].weight) as String) Kg"
        PokemonCard.pokemonFirstType.image = UIImage(named: "\(pokemonData![pokemonIndex].mainType!.name!)")
        PokemonCard.pokemonSecondType.image = UIImage(named: "\(pokemonData![pokemonIndex].secondaryType!)")
//            PokemonCard.pokemonArrowIndicator UIImageView
//            PokemonCard.pokemonDescription.text = ""
    }
    
    func fetchData() {
        do {
            let request = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
            let sort = NSSortDescriptor(key: "number", ascending: true)
            request.sortDescriptors = [sort]
            self.pokemonData = try context.fetch(request)
            
            
            self.firstPokemonMiniature.image = UIImage(data: pokemonData![0].sprite!)
            self.secondPokemonMiniature.image = UIImage(data: pokemonData![1].sprite!)
            self.thirdPokemonMiniature.image = UIImage(data: pokemonData![2].sprite!)
        } catch {
            print(error)
        }
    }
    
    func decrease() {
        if pokemonIndex > 0 {
            pokemonIndex -= 1
        }
        // Descobrir como deixar o botão desabilitado pro else
        updateData()
        print(pokemonIndex)
    }

    func increase() {
        if pokemonIndex < 2 {
            pokemonIndex += 1
        }
        // Descobrir como deixar o botão desabilitado pro else
        updateData()
        print(pokemonIndex)
    }
    
}
