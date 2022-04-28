//
//  MainViewController.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 18.04.2022.
//

import UIKit

class MainViewController: UICollectionViewController  {
    
    var asteroids: [Asteroid] = []
    var dangerousAsteroids: [Asteroid] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.set(true, forKey: "kmDist")
//        UserDefaults.standard.set(false, forKey: "astroHazard")
        fetchAsteroids()
    }

    
    // MARK: - Action Outlets
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        collectionView.reloadData()
     }
   

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UserDefaults.standard.bool(forKey: "astroHazard") ? dangerousAsteroids.count : asteroids.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AsteroidViewCell
        
        switch UserDefaults.standard.bool(forKey: "astroHazard"){
        case true:
            let astro = dangerousAsteroids[indexPath.row]
            cell.astro = astro
            cell.setColor(hazard: astro.is_potentially_hazardous_asteroid)
            cell.configuration(with: astro, and: UserDefaults.standard.bool(forKey: "kmDist"))
        case false:
            let astro = asteroids[indexPath.row]
            cell.astro = astro
            cell.setColor(hazard: astro.is_potentially_hazardous_asteroid)
            cell.configuration(with: astro, and: UserDefaults.standard.bool(forKey: "kmDist"))
        }
        
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


