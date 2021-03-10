//
//  ConfigurationViewController.swift
//  PokeWeather
//
//  Created by Kauê Sales on 05/03/21.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var settingsCard: SettingsCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.layer.cornerRadius = 20
        resetButton.layer.borderWidth = 2
        resetButton.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        settingsCard.layer.cornerRadius = 5
        
        navigationItem.title = "Settings"
    }
    
    @IBAction func resetButton(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Do you really want to restart the application? All your beloved Pokémon will be lost!", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    

}
