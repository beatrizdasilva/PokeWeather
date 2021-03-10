//
//  SettingsCard.swift
//  PokeWeather
//
//  Created by Kauê Sales on 05/03/21.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

class SettingsCard: UIView {
    @IBOutlet var contentView: UIView!
    var tableView: UITableView!
    
    override func awakeFromNib() {
//        setAccessibility()
        contentView.isUserInteractionEnabled = true
        contentView.layer.cornerRadius = 0
        contentView.clipsToBounds = true

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SettingsCard", owner: self, options: nil)
        addSubview(contentView)
        
        configureTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        contentView.addSubview(tableView)
        tableView.frame = contentView.frame
        tableView.layer.cornerRadius = 40
        tableView.tableFooterView = UIView()
    }
    
    

}

extension SettingsCard: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        
        case .About: return SocialSection.allCases.count
        case .Interface: return InterfaceSettings.allCases.count
        case .Comms: return CommunicationSettings.allCases.count
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        
        print(section)
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        
        case .About:
            let social = SocialSection(rawValue: indexPath.row)
            cell.sectionType = social
            
        case .Interface:
            let communications = InterfaceSettings(rawValue: indexPath.row)
            cell.sectionType = communications
        case .Comms:
            let comms = CommunicationSettings(rawValue: indexPath.row)
            cell.sectionType = comms
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        
        switch section {
        
        case .About:
            print(SocialSection(rawValue: indexPath.row)?.description)
        case .Interface:
            print(InterfaceSettings(rawValue: indexPath.row)?.description)
        case .Comms:
            print("a")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
