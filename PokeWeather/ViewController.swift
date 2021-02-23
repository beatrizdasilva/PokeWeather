//
//  ViewController.swift
//  PokeWeather
//
//  Created by Beatriz da Silva on 23/02/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requisicao()
    }
    
    func requisicao(){
        if let url = URL(string: "https://fcc-weather-api.glitch.me/api/current?lat=35&lon=139"){
            URLSession.shared.dataTask(with: url){data, response, error in
                if let data = data{
                    do{
                        let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        print(response)
                    }
                    catch{
                        print(error)
                    }
                }
            }.resume()
        }
    }
}

