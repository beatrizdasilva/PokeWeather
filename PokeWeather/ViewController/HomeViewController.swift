//
//  HomeViewController.swift
//  PokeWeather
//
//  Created by Kauê Sales on 26/02/21.
//

import UIKit
import SpriteKit
import CoreData

class HomeViewController: UIViewController {
    
    var pokemonData: [Pokemon]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//    @IBOutlet weak var imagem: UIImageView!
//    @IBOutlet weak var nome: UILabel!
//    @IBOutlet weak var tipo: UILabel!
//    @IBOutlet weak var peso: UILabel!
    
    private let skView = SKView()
    
    @IBOutlet weak var pokemonCard: PokemonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        requestData(pokeNumber: Int.random(in: 1...150))
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.backgroundColor = .white
        pokemonCard.layer.cornerRadius = pokemonCard.frame.height / 2
        
        setupParticles()
        initSKScene()
    }
    
    @IBAction func fromCoreData(_ sender: Any) {
        do {
            let request = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
            
            //set filtering
//            let pred = NSPredicate(format: "name CONTAINS 'Ayaya'")
//            request.predicate = pred
            
            self.pokemonData = try context.fetch(request)
            
            DispatchQueue.main.async { [self] in
                let pokemon = pokemonData![0]
                self.pokemonCard.pokemonImage.image = UIImage(data: pokemon.sprite!)
                self.pokemonCard.pokemonName.text = pokemon.name
                self.pokemonCard.statusLabel.text = "main: \(pokemon.mainType!.name!), secondary: \(pokemon.secondaryType ?? "batata")"
                self.pokemonCard.advantageLabel.text = "\(pokemon.mainType!.strength![0])"
            }
        } catch {
            print(error)
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
    
    private func initSKScene(){
        let particleScene = ParticleScene(size: CGSize(width: 1080, height: 1920))
        particleScene.scaleMode = .aspectFill
        
        particleScene.backgroundColor = .clear
        
        skView.presentScene(particleScene)
    }
    
    func requestData(pokeNumber: Int) {
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/umbreon") {
            URLSession.shared.dataTask(with: url) { [self] data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(PokeResponse.self, from: data)
                        
                        DispatchQueue.main.async {
                            pokemonCard.pokemonName.text = res.species.name.uppercased()
                            pokemonCard.statusLabel.text =
                                """
                                KKKK SLA A TEMPERATURA FI
                                SEU POKEMON TA MENOS MEME HJ
                                """.lowercased()
                        }
                        updateImage(image: res.sprites.other.officialArtwork.front_default)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func updateImage(image: String) {
        guard let url = URL(string: image) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }

            DispatchQueue.main.async {
                self.pokemonCard.pokemonImage.image = UIImage(data: data!)
            }
        }.resume()
    }

}
