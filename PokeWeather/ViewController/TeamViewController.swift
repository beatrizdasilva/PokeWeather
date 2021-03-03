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
    @IBOutlet weak var PokemonCard: TeamPokemonView!
    @IBOutlet weak var firstPokemonMiniature: UIImageView!
    @IBOutlet weak var secondPokemonMiniature: UIImageView!
    @IBOutlet weak var thirdPokemonMiniature: UIImageView!
    @IBOutlet weak var firstPokemonArrow: UIImageView!
    @IBOutlet weak var secondPokemonArrow: UIImageView!
    @IBOutlet weak var thirdPokemonArrow: UIImageView!
    @IBOutlet weak var shareYourTeam: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBAction func btnPrevious(_ sender: Any) {
        decrease()
    }
    @IBAction func btnNext(_ sender: Any) {
        increase()
    }
    
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupUI()
        btnLeft.isHidden = true
        PokemonCard.layer.cornerRadius = PokemonCard.frame.height / 2
    }
    
    func setupUI() {
        PokemonCard.pokemonImage.image = UIImage(data: pokemonData![pokemonIndex].sprite!)
        PokemonCard.pokemonName.text = pokemonData![pokemonIndex].name?.uppercased()
        PokemonCard.pokemonWeight.text = "\(NSString(format: "%.1f", pokemonData![pokemonIndex].weight) as String) Kg"
        PokemonCard.pokemonFirstType.image = UIImage(named: "\(pokemonData![pokemonIndex].mainType!.name!)")
        PokemonCard.pokemonSecondType.image = UIImage(named: "\(pokemonData![pokemonIndex].secondaryType!)")
        PokemonCard.pokemonDescription.text = "\(pokemonData![pokemonIndex].name!) is a \(pokemonData![pokemonIndex].mainType!.name!) Pokémon and \(true) days make it stronger.\n\nIts advantage is over \(pokemonData![pokemonIndex].mainType!.strength!) Pokémon, but it has a disadvantage for those of \(true)"
//        PokemonCard.pokemonArrowIndicator UIImageView
        
        btnLeft.isHidden = false
        btnRight.isHidden = false
        if pokemonIndex == 0 {
            btnLeft.isHidden = true
        }
        if pokemonIndex == 2 {
            btnRight.isHidden = true
        }
        
        // Change colors according to the type of pokémon
        self.view.backgroundColor = UIColor(named: "\(pokemonData![pokemonIndex].mainType!.name!)Background")
        btnLeft.tintColor = UIColor(named: "\(pokemonData![pokemonIndex].mainType!.name!)Highlight")
        btnRight.tintColor = UIColor(named: "\(pokemonData![pokemonIndex].mainType!.name!)Highlight")
        
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
        setupUI()
        print(pokemonIndex)
    }
    
    func increase() {
        if pokemonIndex < 2 {
            pokemonIndex += 1
        }
        setupUI()
        print(pokemonIndex)
    }
    
}
