//
//  TeamPokemonView.swift
//  PokeWeather
//
//  Created by Beatriz da Silva on 01/03/21.
//

import UIKit

protocol TeamPokemonViewDelegate {
    func increase()
    func decrease()
}

class TeamPokemonView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonArrowIndicator: UIImageView!
    @IBOutlet weak var pokemonFirstType: UIImageView!
    @IBOutlet weak var pokemonSecondType: UIImageView!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonDescription: UILabel!
    
    override func awakeFromNib() {
        contentView.isUserInteractionEnabled = true
        contentView.layer.cornerRadius = 40
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
        Bundle.main.loadNibNamed("TeamPokemonView", owner: self, options: nil)
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    

}
