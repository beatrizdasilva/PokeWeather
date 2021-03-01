//
//  InitialViewController.swift
//  PokeWeather
//
//  Created by Kauê Sales on 01/03/21.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet var curvedCard: UIView!
    
    @IBOutlet weak var randomDateButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var monthField: UITextField!
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        monthField.textAlignment = .center
        monthField.inputView = pickerView
        monthField.placeholder = "Month"
        monthField.isHidden = true
        // Do any additional setup after loading the view.
        
        curvedCard.translatesAutoresizingMaskIntoConstraints = true
        curvedCard.topAnchor.constraint(equalTo: view.topAnchor, constant: -11).isActive = true
        
        continueButton.layer.cornerRadius = 20
        continueButton.layer.backgroundColor = CGColor(red: 3/255, green: 198/255, blue: 187/255, alpha: 1.0)
        
        randomDateButton.layer.cornerRadius = 20
        randomDateButton.layer.borderWidth = 2
//        continueButton.layer.backgroundColor = CGColor(red: 2/255, green: 188/255, blue: 173/255, alpha: 1.0)
        randomDateButton.layer.borderColor = CGColor(red: 3/255, green: 198/255, blue: 187/255, alpha: 1.0)
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

extension InitialViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return months.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return months[row]
    }
    
    
}
