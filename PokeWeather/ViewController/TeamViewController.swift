//
//  TeamViewController.swift
//  PokeWeather
//
//  Created by Beatriz da Silva on 01/03/21.
//
import UIKit
import CoreData

class TeamViewController: UIViewController {
    // MARK: - Variables
    var pokemonIndex = 0
    var pokemonData: [Pokemon]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: - Outlets
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
    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        firstPokemonMiniature.backgroundColor = UIColor(named: "\(pokemonData![0].mainType!.name!)Table")
        firstPokemonMiniature.layer.cornerRadius = firstPokemonMiniature.frame.height / 2
        
        secondPokemonMiniature.backgroundColor = UIColor(named: "\(pokemonData![1].mainType!.name!)Table")
        secondPokemonMiniature.layer.cornerRadius = firstPokemonMiniature.frame.height / 2
        
        thirdPokemonMiniature.backgroundColor = UIColor(named: "\(pokemonData![2].mainType!.name!)Table")
        thirdPokemonMiniature.layer.cornerRadius = firstPokemonMiniature.frame.height / 2
        
        setupUI()
        btnLeft.tintColor = .clear
        PokemonCard.layer.cornerRadius = PokemonCard.frame.height / 2
        
        firstPokemonMiniature.layer.borderWidth = 3
        secondPokemonMiniature.layer.borderWidth = 0
        thirdPokemonMiniature.layer.borderWidth = 0
        
        firstPokemonMiniature.layer.borderColor = UIColor(named: "\(pokemonData![0].mainType!.name!)Highlight")?.cgColor
        secondPokemonMiniature.layer.borderColor = UIColor(named: "\(pokemonData![1].mainType!.name!)Highlight")?.cgColor
        thirdPokemonMiniature.layer.borderColor = UIColor(named: "\(pokemonData![2].mainType!.name!)Highlight")?.cgColor
        
        // calls setAccessibility from TeamViewController
        setAccessibility()
    }
    
    func setupUI() {
        PokemonCard.pokemonImage.image = UIImage(data: pokemonData![pokemonIndex].sprite!)
        PokemonCard.pokemonName.text = pokemonData![pokemonIndex].name?.uppercased()
        PokemonCard.pokemonWeight.text = "\(NSString(format: "%.1f", pokemonData![pokemonIndex].weight) as String) Kg"
        PokemonCard.pokemonFirstType.image = UIImage(named: "\(pokemonData![pokemonIndex].mainType!.name!)")
        PokemonCard.pokemonSecondType.image = UIImage(named: "\(pokemonData![pokemonIndex].secondaryType!)")
        PokemonCard.pokemonDescription.text = "\(pokemonData![pokemonIndex].name!) is a \(pokemonData![pokemonIndex].mainType!.name!) Pokémon and \(true) days make it stronger.\n\nIts advantage is over \(pokemonData![pokemonIndex].mainType!.strength!) Pokémon, but it has a disadvantage for those of \(true)"
        //        PokemonCard.pokemonArrowIndicator UIImageView
        
        
        // Change colors according to the type of pokémon
        self.view.backgroundColor = UIColor(named: "\(pokemonData![pokemonIndex].mainType!.name!)Background")
        
        firstPokemonMiniature.layer.borderWidth = 0
        secondPokemonMiniature.layer.borderWidth = 0
        thirdPokemonMiniature.layer.borderWidth = 0
        
        if pokemonIndex == 0 {
            btnLeft.tintColor = .clear
            btnRight.tintColor = UIColor(named: "\(pokemonData![pokemonIndex].mainType!.name!)Highlight")
            firstPokemonMiniature.layer.borderWidth = 3
            
        }
        
        if pokemonIndex == 1 {
            btnLeft.tintColor = UIColor(named: "\(pokemonData![pokemonIndex].mainType!.name!)Highlight")
            btnRight.tintColor = UIColor(named: "\(pokemonData![pokemonIndex].mainType!.name!)Highlight")
            secondPokemonMiniature.layer.borderWidth = 3
        }
        
        if pokemonIndex == 2 {
            btnLeft.tintColor = UIColor(named: "\(pokemonData![pokemonIndex].mainType!.name!)Highlight")
            btnRight.tintColor = .clear
            thirdPokemonMiniature.layer.borderWidth = 3
        }
        
        // Calls setAccessibility from TeamPokemonView
        PokemonCard.setAccessibility()
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
    
    @IBAction func btnPrevious(_ sender: Any) {
        decrease()
    }
    @IBAction func btnNext(_ sender: Any) {
        increase()
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

// MARK: - Accessibility
extension TeamViewController {
    func setAccessibility() {
        firstPokemonMiniature.accessibilityLabel = "\(pokemonData![0].name ?? "pokemon") miniature"
        firstPokemonMiniature.accessibilityTraits = UIAccessibilityTraits.image
        
        secondPokemonMiniature.accessibilityLabel = "\(pokemonData![1].name ?? "pokemon") miniature"
        secondPokemonMiniature.accessibilityTraits = UIAccessibilityTraits.image
        
        thirdPokemonMiniature.accessibilityLabel = "\(pokemonData![2].name ?? "pokemon") miniature"
        thirdPokemonMiniature.accessibilityTraits = UIAccessibilityTraits.image
        
        /* Como renomear as setas?
        firstPokemonArrow.accessibilityLabel = "arrowUpOrDown image"
        firstPokemonArrow.accessibilityTraits = UIAccessibilityTraits.image
        
        secondPokemonArrow.accessibilityLabel = "arrowUpOrDown image"
        secondPokemonArrow.accessibilityTraits = UIAccessibilityTraits.image
        
        thirdPokemonArrow.accessibilityLabel = "arrowUpOrDown image"
        thirdPokemonArrow.accessibilityTraits = UIAccessibilityTraits.image
        */
        
        shareYourTeam.accessibilityLabel = "Share your team"
        shareYourTeam.accessibilityHint = "Double tap to share your team on social media."
        shareYourTeam.accessibilityTraits = UIAccessibilityTraits.button
        
        /* VoiceOver lê o botão quando ele esta invisível, pq ele ainda está lá */
        btnLeft.accessibilityLabel = "Previous"
        btnLeft.accessibilityHint = "Double tap to see the previous member of your Pokémon team."
        btnLeft.accessibilityTraits = UIAccessibilityTraits.button
        
        btnRight.accessibilityLabel = "Next"
        btnRight.accessibilityHint = "Double tap to see the next member of your Pokémon team."
        btnRight.accessibilityTraits = UIAccessibilityTraits.button
    }
}
