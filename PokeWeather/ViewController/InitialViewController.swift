//
//  InitialViewController.swift
//  PokeWeather
//
//  Created by Kauê Sales on 01/03/21.
//

import UIKit
import CoreData

class InitialViewController: UIViewController {
    // MARK: - Variables
    var activityIndicator: UIActivityIndicatorView!
    var success = 0
    var types: [PokemonType]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    var pokemonValues: [String.SubSequence] = []
    
    
    // MARK: - Outlets
    @IBOutlet var curvedCard: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var randomDateButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!


    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is UITabBarController  {
//            let vc = segue.destination as? UITabBarController
//        }
//    }
//
    func setupUI() {
        let boldText = "Developed by: "
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 8)]
        let developerFinalLabel = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = "Beatriz da Silva, Juliana Machado e Kauê Sales"
        let normalString = NSMutableAttributedString(string:normalText)
        
        developerFinalLabel.append(normalString)
        
        developerLabel.attributedText = developerFinalLabel
        
        let boldText2 = "Credits: "
        let creditsFinalLabel = NSMutableAttributedString(string:boldText2, attributes:attrs)
        
        let normalText2 = "PokeAPI and Free Code Camp weather API"
        let normalString2 = NSMutableAttributedString(string:normalText2)
        
        creditsFinalLabel.append(normalString2)
        creditsLabel.attributedText = creditsFinalLabel
        creditsLabel.clipsToBounds = true
        
        curvedCard.translatesAutoresizingMaskIntoConstraints = false
        curvedCard.topAnchor.constraint(equalTo: view.topAnchor, constant: -35).isActive = true
        curvedCard.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        curvedCard.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        continueButton.layer.cornerRadius = 20
        continueButton.layer.backgroundColor = CGColor(red: 3/255, green: 202/255, blue: 188/255, alpha: 1.0)
        
        randomDateButton.layer.cornerRadius = 20
        randomDateButton.layer.borderWidth = 2
        //        continueButton.layer.backgroundColor = CGColor(red: 2/255, green: 188/255, blue: 173/255, alpha: 1.0)
        randomDateButton.layer.borderColor = CGColor(red: 3/255, green: 198/255, blue: 187/255, alpha: 1.0)
    }
    
    @IBAction func randomDateButtonPressed(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/M/d"
        
        let stringDate = dateFormatter.string(from: datePicker.date)
        pokemonValues = stringDate.split(separator: "/")
        
        if pokemonValues[0] == "00" {
            pokemonValues[0] = "100"
        }
        
        if pokemonValues[0] < "10" {
            pokemonValues[0].remove(at: pokemonValues[0].startIndex)
        }
        
        print(pokemonValues)
        
        
        pokemonValues[0] = "\(Int.random(in: 1...100))"
        pokemonValues[1] = "\(Int.random(in: 101...300))"
        pokemonValues[2] = "\(Int.random(in: 301...493))"
        
        
        print(pokemonValues)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(increaseSuccess), name: Notification.Name(rawValue: "SUCCESS_OK"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeScreen), name: Notification.Name(rawValue: "SAVED_OK"), object: nil)
        
//        for i in 0...2 {
//            requestPokemonData(value: String(pokemonValues[i]))
//        }
        
        requestPokemonData(value: "articuno")
        requestPokemonData(value: "squirtle")
        requestPokemonData(value: "umbreon")
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/M/d"
        
        let stringDate = dateFormatter.string(from: datePicker.date)
        pokemonValues = stringDate.split(separator: "/")
        
        print(pokemonValues)
        
        if pokemonValues[0] == "00" {
            pokemonValues[0] = "100"
        }
        
        if pokemonValues[0] < "10" {
            pokemonValues[0].remove(at: pokemonValues[0].startIndex)
        }
        
        print(pokemonValues)
        
        if pokemonValues[2] == pokemonValues[1] {
            pokemonValues[1] = "\(Int.random(in: 101...200))"
        }
        
        if pokemonValues[2] == pokemonValues[0] || pokemonValues[1] == pokemonValues [0] {
            pokemonValues[0] = "\(Int.random(in: 201...493))"
        }
        
        print(pokemonValues)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(increaseSuccess), name: Notification.Name(rawValue: "SUCCESS_OK"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeScreen), name: Notification.Name(rawValue: "SAVED_OK"), object: nil)

        for i in 0...2 {
            requestPokemonData(value: String(pokemonValues[i]))
        }
        
    }

    
    @objc func changeScreen() {
        DispatchQueue.main.async { [self] in
            defaults.setValue(true, forKey: "AcessoPrimeiraVez")
            performSegue(withIdentifier: "Navigation", sender: nil)
        }
    }
    
    @objc func increaseSuccess() {
        DispatchQueue.main.async { [self] in
            if success < 2 {
                success += 1
                print("incresed")
            } else if success == 2 {
                print("done")
                NotificationCenter.default.post(name: Notification.Name("SAVED_OK"), object: nil)
            }
        }
    }
    
    func requestPokemonData(value: String) {
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/" + value) {
            URLSession.shared.dataTask(with: url) { [self] data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(PokeResponse.self, from: data)
                        print(res)
                        requestPokemonImage(pokemonData: res)
                        
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func requestPokemonImage(pokemonData: PokeResponse){
        guard let url = URL(string: pokemonData.sprites.other.officialArtwork.front_default) else { return }
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            savePokemonData(pokemonData: pokemonData, pokemonImage: data!)
            
        }.resume()
    }
    
    func savePokemonData(pokemonData: PokeResponse, pokemonImage: Data) {
        fetchType(type: pokemonData.types[0].type.name) //get an official type from the database
        
        
        let newPokemon = Pokemon(context: self.context) //creates an object in context
        
        //setting parameters
        newPokemon.name = pokemonData.species.name
        newPokemon.number = Int64(pokemonData.id)
        newPokemon.sprite = pokemonImage
        newPokemon.weight = String(Float(pokemonData.weight) / 10)
        
        newPokemon.mainType = (types![0]) //insert into a real table
        
        if pokemonData.types.count > 1 {
            newPokemon.secondaryType = pokemonData.types[1].type.name
        } else {
            newPokemon.secondaryType = "Not Available"
        }
        

        
        do {
            try self.context.save()
            print("saved")
        } catch {
            print(error)
        }
        
        NotificationCenter.default.post(name: Notification.Name("SUCCESS_OK"), object: nil)
        
    }
    
    func fetchType(type: String) {
        do {
            let request = PokemonType.fetchRequest() as NSFetchRequest<PokemonType>
            
            //set filtering
            let pred = NSPredicate(format: "name CONTAINS '\(type)'")
            request.predicate = pred
            
            self.types = []
            self.types = try context.fetch(request)
        } catch {
            print(error)
        }
    }
}


// MARK: - Accessibility
extension InitialViewController {
    func setAccessibility() {
        randomDateButton.accessibilityLabel = "Random Date"
        randomDateButton.accessibilityHint = "Double tap to generate a random date."
        randomDateButton.accessibilityTraits = UIAccessibilityTraits.button
        
        continueButton.accessibilityLabel = "Continue"
        continueButton.accessibilityHint = "Double tap to confirm the date you entered in the datepicker."
        continueButton.accessibilityTraits = UIAccessibilityTraits.button
        
        developerLabel.accessibilityLabel = "Developed by Beatriz da Silva, Juliana Machado and Kauê Sales"
        developerLabel.accessibilityTraits = UIAccessibilityTraits.staticText

        creditsLabel.accessibilityLabel = "Credits to PokeAPI and Free Code Camp weather API"
        creditsLabel.accessibilityTraits = UIAccessibilityTraits.staticText
    }
}
