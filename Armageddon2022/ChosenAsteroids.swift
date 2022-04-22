//
//  ChosenAsteroids.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 22.04.2022.
//

import Foundation

class ChosenAsteroid {
    static let shared = ChosenAsteroid()
    
    private init() {}
    
    var chosenAsteroid: [Asteroid] = []
    
    func addNewAsterroid(astr: Asteroid) {
        chosenAsteroid.append(astr)
    }
    
    func deletedAllAsteroids() {
        chosenAsteroid.removeAll()
    }
    
}
