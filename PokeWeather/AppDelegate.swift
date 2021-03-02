//
//  AppDelegate.swift
//  PokeWeather
//
//  Created by Beatriz da Silva on 23/02/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preloadPokemonTypeData()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        var storyboard = UIStoryboard(name: "Home", bundle: nil)
        var vc: UIViewController?
        
        let ud = UserDefaults.standard.bool(forKey: "AcessoPrimeiraVez")
        
//        if ud == false {
//            print("first time")
            vc = storyboard.instantiateInitialViewController()
//        }
//
//        if ud == true {
//            print("not the firstTime")
//            storyboard = UIStoryboard(name: "Navigation", bundle: nil)
//            vc = storyboard.instantiateInitialViewController()
//        }
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PokeDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func preloadPokemonTypeData() {
        let preloadDataKey = "didPreloadData"
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: preloadDataKey) == false {
            guard let urlPath = Bundle.main.url(forResource: "PokemonTypes", withExtension: ".json") else { return }
            
            if let contents = NSData(contentsOf: urlPath) {
                let response = try! JSONDecoder().decode(TypeDataResponse.self, from: contents as Data)
                for type in response.results {
                    requestStrAndWk(name: type.name)
                }
            }
            
            userDefaults.setValue(true, forKey: preloadDataKey)
        }
    }
    
    private func requestStrAndWk(name: String) {
        let url = URL(string: "https://pokeapi.co/api/v2/type/" + name)!
        
        let backgroundContext = persistentContainer.newBackgroundContext()
        
        backgroundContext.perform {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                let response = try! JSONDecoder().decode(damageResponse.self, from: data!)
                var pokeWeakness: [String] = []
                var pokeStrength: [String] = []
                
                for weakness in response.damage_relations.double_damage_from {
                    pokeWeakness.append(weakness.name)
                }
                
                for strength in response.damage_relations.double_damage_to {
                    pokeStrength.append(strength.name)
                }

                let pokemonType = PokemonType(context: backgroundContext)
                pokemonType.name = name
                pokemonType.weakness = pokeWeakness
                pokemonType.strength = pokeStrength
                
//                print(name, pokeWeakness, pokeStrength)
                try! backgroundContext.save()
            }
            task.resume()
        }
        
    }

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

