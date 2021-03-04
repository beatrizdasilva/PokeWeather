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

protocol ParticleEmitterDelegate {
    func setupParticleEmitter(type: String)
}

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    var pokemonData: [Pokemon]?
    @IBOutlet weak var weatherImageView: UIImageView!
    var particleEmitterDelegate: ParticleEmitterDelegate?
    
    let locationManager = (UIApplication.shared.delegate as! AppDelegate).locationManager
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let skView = SKView()
    
    @IBOutlet weak var pokemonCard: PokemonView!
    var currentLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.backgroundColor = .white
        pokemonCard.layer.cornerRadius = pokemonCard.frame.height / 2
        
//        self.tabBarController?.tabBar.selectedItem?.image = UIImage(named: "homeOn")?.withRenderingMode(.alwaysOriginal)
//        self.tabBarController?.tabBar.selectedImage = UIImage(named: "homeOn")?.withRenderingMode(.alwaysOriginal)
        
        setupParticles()
//        initSKScene()
        setupLocation()
        fetchStrongestPokemon()
        fromCoreData(self)
    }
    
    @IBAction func fromCoreData(_ sender: Any) {
        do {
            let request = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
            
            self.pokemonData = try context.fetch(request)
            print(pokemonData?.count)
            
            updateUI()
            
        } catch {
            print(error)
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async { [self] in
            
            //UPDATES IN XIB
            let pokemon = pokemonData![0]
            let pokeType = (pokemon.mainType!.name!)
            self.pokemonCard.pokemonImage.image = UIImage(data: pokemon.sprite!)
            self.pokemonCard.pokemonName.text = pokemon.name
            self.pokemonCard.statusLabel.text = "main: \(pokemon.mainType!.name!), secondary: \(pokemon.secondaryType ?? "batata")"
            self.pokemonCard.advantageLabel.text = "\(pokemon.mainType!.strength![0])"
            
            //UPDATES IN BACKGROUND
            view.backgroundColor = UIColor(named: "\(pokeType)Background")
            initSKScene(type: pokeType)
        }
    }
    
    func fetchStrongestPokemon() {
       
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
