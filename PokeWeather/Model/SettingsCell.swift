//
//  Settingscell.swift
//  PokeWeather
//
//  Created by Kauê Sales on 05/03/21.
//

import UIKit

class SettingsCell: UITableViewCell {
    // MARK: - Properties
    
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            textLabel!.text = sectionType.description
            switchControl.isHidden = !sectionType.containsSwitch
            switchControl.tag = sectionType.id
            
        }
    }
    
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isUserInteractionEnabled = true
        switchControl.isOn = true
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(switchControl)
        
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc func handleSwitchAction(sender: UISwitch) {
        if sender.isOn {
            if sender.tag == 1 {
                print("email ligado")
            }
        } else {
            if sender.tag == 1 {
                print("email desligado")
            }
        }
    }
    
 
}
