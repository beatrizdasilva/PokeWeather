//
//  HomeViewController.swift
//  PokeWeather
//
//  Created by Kauê Sales on 26/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var peso: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestData(pokeNumber: Int.random(in: 1...150))
    }
    
    func requestData(pokeNumber: Int) {
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/" + String(pokeNumber)) {
            URLSession.shared.dataTask(with: url) { [self] data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(PokeResponse.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.nome.text = res.species.name
                            self.tipo.text = String(res.weight)
                        }
                        
                        
                        self.updateImage(image: res.sprites.other.officialArtwork.front_default)
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
                self.imagem.image = UIImage(data: data!)
            }
        }.resume()
    }

}
