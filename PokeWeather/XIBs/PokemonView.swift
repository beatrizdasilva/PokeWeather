//
//  PokemonView.swift
//  PokeWeather
//
//  Created by Kauê Sales on 28/02/21.
//

import UIKit

class PokemonView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var advantageLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        contentView.isUserInteractionEnabled = false
        contentView.layer.cornerRadius = 40
        
        pokemonImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        advantageLabel.text = "meme ipsum"
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 15
        contentView.layer.shadowOpacity = 0.42
        contentView.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PokemonView", owner: self, options: nil)
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}
