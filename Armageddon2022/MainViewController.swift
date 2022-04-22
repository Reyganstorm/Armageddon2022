//
//  MainViewController.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 18.04.2022.
//

import UIKit

protocol SettingsDelegate {
    func setNewSettings(for distanceCount: Bool, and potentialHazard: Bool)
}

protocol CollectionViewDelegate {
    func addAsteroid(asteroid: Asteroid)
}

class MainViewController: UICollectionViewController  {
    
    var asteroids: [Asteroid] = []
    var dangerousAsteroids: [Asteroid] = []
    var kmDistance: Bool = true
    var dangerous = false

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAsteroids()
    }

   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {return}
        settingsVC.delegate = self
        settingsVC.kmDistance = self.kmDistance
        settingsVC.dangerous = self.dangerous
    }
   

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dangerous ? dangerousAsteroids.count : asteroids.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AsteroidViewCell
        
        switch dangerous {
        case true:
            let astro = dangerousAsteroids[indexPath.row]
            cell.astro = astro
            cell.configuration(with: astro, and: kmDistance)
            //cell.destroyTheAsteroid(astro: astro)
        case false:
            let astro = asteroids[indexPath.row]
            cell.astro = astro
            cell.configuration(with: astro, and: kmDistance)
            //cell.destroyTheAsteroid(astro: astro)
        }
        cell.contentView.layer.borderWidth = 0.6
        
        return cell
    }
}

extension MainViewController {
    private func fetchAsteroids() {
        NetworkManager.shared.fetch(from: Links.allAsteroids.rawValue, completion: { result in
            switch result {
            case .success(let asteroids):
                self.asteroids = self.separator(for: asteroids.near_earth_objects)
                self.dangerousAsteroids = self.findDangerousAsteroids()
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func separator(for dictionary: [String: [Asteroid]]) -> [Asteroid] {
        var count: [Asteroid] = []
        for (_, array) in dictionary {
            for ast in array {
                count.append(ast)
            }
        }
        return count
    }
    
    private func findDangerousAsteroids() -> [Asteroid] {
        for asteroid in asteroids {
            if asteroid.is_potentially_hazardous_asteroid {
                dangerousAsteroids.append(asteroid)
            }
        }
        return dangerousAsteroids
    }
}

extension MainViewController: SettingsDelegate {
    func setNewSettings(for distanceCount: Bool, and potentialHazard: Bool) {
        self.kmDistance = distanceCount
        self.dangerous = potentialHazard
        self.collectionView.reloadData()
    }
}

