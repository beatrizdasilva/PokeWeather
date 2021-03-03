//
//  ParticleScene.swift
//  PokeWeather
//
//  Created by Kauê Sales on 01/03/21.
//

import Foundation
import SpriteKit

class ParticleScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        setupParticleEmitter()
    }
    
    //starting from above -50, from below -1920, from middle /2.
    private func setupParticleEmitter() {
        let particleEmitter = SKEmitterNode(fileNamed: "WaterParticles")!
        particleEmitter.position = CGPoint(x: size.width/2, y: size.height - 50)
        addChild(particleEmitter)
    }
}
