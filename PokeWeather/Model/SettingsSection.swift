//
//  SettingsSection.swift
//  PokeWeather
//
//  Created by Kauê Sales on 05/03/21.
//

import UIKit

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
    var id: Int { get }
    
}


enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case About
    case Interface 
    case Comms
    
    var description: String {
        switch self {
        case .About: return "About"
        case .Interface: return "Interface and Usability"
        case .Comms: return "Communications"
        
        }
    }
}

enum SocialSection: Int, CaseIterable, SectionType {
    var id: Int {
        switch self {
        case .github:
            return 5
        }
    }
    
    
    var containsSwitch: Bool {
        switch self {
        case .github: return false
        }
        
    }
    
    case github
    
    var description: String {
        switch self {
        case .github: return "Github Repo"

        }
    }
}

enum InterfaceSettings: Int, CaseIterable, SectionType {
    var id: Int {
        switch self {
        case .vibration:
            return 1
        case .simpleInterface:
            return 2
        case .particles:
            return 3
        case .partycles:
            return 4
        }
    }
    

    
    var containsSwitch: Bool {
        switch self {
        case .vibration: return true
        case .simpleInterface: return true
        case .particles: return true
        case .partycles: return true
    }}
    
//    var notificationSwitch: Bool {
//        switch self {
//        case .email: return false
//        case .notifications: return true
//        case .reportCrashes: return false
//    }}
    
    case vibration
    case simpleInterface
    case particles
    case partycles
    
    var description: String {
        switch self {
        case .vibration: return "Vibration"
        case .simpleInterface: return "Simple Interface"
        case .particles: return "Particles"
        case .partycles: return "PARTY!cles"
        }
    }
}

enum CommunicationSettings: Int, CaseIterable, SectionType {
    var id: Int {
        switch self {
        case .notifications:
            return 2
        }
    }
    

    
    var containsSwitch: Bool {
        switch self {
        case .notifications: return true
    }}
    
    case notifications

    
    var description: String {
        switch self {
        case .notifications:return "Notifications"
        }
    }
}



