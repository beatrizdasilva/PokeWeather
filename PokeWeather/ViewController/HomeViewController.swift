//
//  HomeViewController.swift
//  PokeWeather
//
//  Created by Kauê Sales on 26/02/21.
//

import UIKit
import SpriteKit
import CoreData
import CoreLocation

var priorityPokemonType: [String]?

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: - Variables
    var pokemonData: [Pokemon]?
    var currentLocation: CLLocation?
    let locationManager = (UIApplication.shared.delegate as! AppDelegate).locationManager
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var weatherNow: weatherResponse = .clouds
    private let skView = SKView()
    var weatherTypeToday: String?
    
    
    // MARK: - Outlets
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var pokemonCard: PokemonView!
    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.backgroundColor = .white
        pokemonCard.layer.cornerRadius = pokemonCard.frame.height / 2
        
        setupLocation()
        setupParticles()
    }
    
    func fetchFromCoreData() {
        do {
            let request = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
            
            self.pokemonData = try context.fetch(request)
            print(pokemonData?.count)
            
            //updateUI() -> fetchStrongestPokemon vai dar update na ui
        } catch {
            print(error)
        }
    }
    
    func updateUI(pokemon: Pokemon) {
        DispatchQueue.main.async { [self] in
            
            
            var types = ""
            //UPDATES IN XIB
            let pokemon = pokemon
            print(pokemon.name!)
            let pokeType = (pokemon.mainType!.name!)
            self.pokemonCard.pokemonImage.image = UIImage(data: pokemon.sprite!)
            self.pokemonCard.pokemonName.text = pokemon.name?.uppercased()
            self.pokemonCard.statusLabel.text = "What a \(weatherTypeToday!) day!!! \nYour \(pokemon.name!.uppercased()) is stronger!"
            
            self.pokemonCard.statusArrow.image = UIImage(named: "newDown")
            
            for strength in pokemon.mainType!.strength! {
                types.append("\(strength), ")
            }
            
            self.pokemonCard.advantageLabel.text = "It has an advantage against \n\(types) types!"

            
            for type in priorityPokemonType! {
                if pokemon.mainType?.name == type {
                    self.pokemonCard.statusArrow.image = UIImage(named: "newUp")
                    break
                }
                
            }
            
            //UPDATES IN BACKGROUND
            view.backgroundColor = UIColor(named: "\(pokeType)Background")
            initSKScene(type: pokeType)
            pokemonCard.setAccessibility()
        }
    }
    
    func fetchStrongestPokemon() {
        
        var choosenPokemon: [Pokemon] = []
        
        do {
            let request = Pokemon.fetchRequest() as NSFetchRequest <Pokemon>
            self.pokemonData = try context.fetch(request)
            
            
            for type in priorityPokemonType! {
                for index in pokemonData! {
                    if index.mainType?.name! == type {
                        print(index.name)
                        choosenPokemon.append(index)
                    }
                }
            }
            
            if choosenPokemon.count == 0 {
                choosenPokemon = pokemonData!
            }
            
            if choosenPokemon.count == 1 {
                updateUI(pokemon: choosenPokemon[0])
            } else {
  
                choosenPokemon.sort(by: {$0.weight! < $1.weight!})
//                print(choosenPokemon)
                updateUI(pokemon: choosenPokemon[0])
            }
        } catch {
            print(error)
        }
        
        
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            updateWeatherData()
        }
    }
    
    func updateWeatherData() {
        guard let currentLocation = currentLocation else { return }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        print("\(long) | \(lat)")
        
        if let url = URL(string: "https://fcc-weather-api.glitch.me/api/current?lat=\(lat)&lon=\(long)") {
            URLSession.shared.dataTask(with: url) { [self] data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        
                        if res.name != "Shuzenji" {
                            print(res.weather[0].main)
//                            currentWeather = res
                            DispatchQueue.main.async {
                                weatherImageView.image = UIImage(named: "\(res.weather[0].main)")
                                
                                if res.weather[0].main == "Clear" {
                                    priorityPokemonType = ["fire", "grass", "ground", "normal", "rock"]
                                    weatherTypeToday = "clear"
                                } else if res.weather[0].main == "Clouds" {
                                    priorityPokemonType = ["fairy", "fighting", "poison"]
                                    weatherTypeToday = "cloudy"
                                } else if res.weather[0].main == "Mist" {
                                    priorityPokemonType = ["dark", "ghost"]
                                } else if res.weather[0].main == "Rain" {
                                    priorityPokemonType = ["water", "electric", "bug"]
                                    weatherTypeToday = "rainy"
                                } else if res.weather[0].main == "Thunderstorm" {
                                    priorityPokemonType = ["dragon", "flying", "psychic"]
                                    weatherTypeToday = "stormy"
                                } else if res.weather[0].main == "Snow" {
                                    priorityPokemonType = ["ice", "steel"]
                                    weatherTypeToday = "snowy"
                                }
                                
                                fetchStrongestPokemon()
                            }
                            
                            UserDefaults.standard.setValue("\(res.weather[0].main)", forKey: "currentWeather")
                        } else {
                            updateWeatherData()
                        }
                        
                    } catch {
                        print(error)
                    }
                }
                
            }.resume()
        }
    }
    
    private func setupParticles(){
        view.addSubview(skView)
        view.sendSubviewToBack(skView)
        
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.allowsTransparency = true
        
        let top = skView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        let leading = skView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        let trailing = skView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        let bottom = skView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
    private func initSKScene(type: String){
        let particleScene = ParticleScene(size: CGSize(width: 1080, height: 1920))
        particleScene.scaleMode = .aspectFill
        
        particleScene.backgroundColor = .clear
        particleScene.setupParticleEmitter(type: type)
        
        skView.presentScene(particleScene)
    }

}

// MARK: - Accessibility
extension HomeViewController {
    func setAccessibility() {
        // Como pegar o nome do clima que está fazendo?
        weatherImageView.accessibilityLabel = ""
        weatherImageView.accessibilityTraits = UIAccessibilityTraits.image
        
    }
}
