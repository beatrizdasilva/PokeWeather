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
        
//        testLabel.text = "teste"
        
        
        resetButton.layer.cornerRadius = 20
        resetButton.layer.borderWidth = 2
        resetButton.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        //resetButton.layer.backgroundColor = CGColor(red: 3/255, green: 202/255, blue: 188/255, alpha: 1.0)
        
        settingsCard.layer.cornerRadius = 5
    

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Settings"
    }
    
    @IBAction func resetButton(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Do you really want to restart the application? All your beloved Pokémon will be lost!", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
