//
//  UIButtonExtension.swift
//  PokeWeather
//
//  Created by Kauê Sales on 03/03/21.
//

import UIKit

extension UIButton {
    func animateButton(shouldLoad: Bool, color: UIColor) {
        let sp = UIActivityIndicatorView()
        sp.style = UIActivityIndicatorView.Style.large
        sp.color = color
        sp.alpha = 0.0
        sp.hidesWhenStopped = true
        sp.tag = 21
        
        if shouldLoad {
            self.addSubview(sp)
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = self.frame.height / 2
                self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }, completion: { (finished) in
                if finished == true {
                    sp.startAnimating()
                    sp.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.width / 2 + 1)
                    sp.fadeTo(alphaValue: 1.0, withDuration: 0.2)
                }
            
            })
            
            self.isUserInteractionEnabled = false
        }
    }
}
