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
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonArrowIndicator: UIImageView!
    @IBOutlet weak var pokemonFirstType: UIImageView!
    @IBOutlet weak var pokemonSecondType: UIImageView!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonDescription: UILabel!
    
    // MARK: - Functions
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
        setAccessibility()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TeamPokemonViewNovoNome", owner: self, options: nil)
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}


// MARK: - Accessibility
extension TeamPokemonView {
    func setAccessibility() {
        pokemonImage.accessibilityLabel = "\(pokemonName.text!)"
        pokemonImage.accessibilityTraits = UIAccessibilityTraits.image
        
        pokemonName.accessibilityLabel = "\(pokemonName.text!)"
        pokemonName.accessibilityTraits = UIAccessibilityTraits.staticText
        
        // Arrow indicator image
        pokemonArrowIndicator.accessibilityLabel = "arrow up/down"
        pokemonArrowIndicator.accessibilityTraits = UIAccessibilityTraits.image
        
        // Trazer info de tipo pra cá
        pokemonFirstType.accessibilityLabel = ""
        pokemonFirstType.accessibilityTraits = UIAccessibilityTraits.image
        
        pokemonSecondType.accessibilityLabel = ""
        pokemonSecondType.accessibilityTraits = UIAccessibilityTraits.image
    }
}
