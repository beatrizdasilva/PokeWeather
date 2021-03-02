//
//  InitialScreenCurvedLabelView.swift
//  PokeWeather
//
//  Created by Kauê Sales on 01/03/21.
//

import UIKit

class InitialScreenCurvedLabelView: UIView {

    @IBOutlet var contentView: UIView!

    override func awakeFromNib() {
        contentView.isUserInteractionEnabled = false
        contentView.layer.cornerRadius = 40
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("InitialScreenCurvedLabel", owner: self, options: nil)
        addSubview(contentView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}
