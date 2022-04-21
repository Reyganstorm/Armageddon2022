//
//  MainViewController.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 18.04.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainViewController: UICollectionViewController {
    
    var casedAsteroids: [String: [Asteroid]] = [:]
    var asteroids: [Asteroid] = []
    var kmDistance: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAsteroids()
        print(casedAsteroids.count)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        asteroids.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AsteroidViewCell
    
        // Configure the cell
        let astro = asteroids[indexPath.row]
        cell.contentView.layer.borderWidth = 0.6
        cell.configuration(with: astro, and: kmDistance)

      
        return cell
    }
  

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension MainViewController {
    private func fetchAsteroids() {
        NetworkManager.shared.fetch(from: Links.allAsteroids.rawValue, completion: { result in
            switch result {
            case .success(let asteroids):
                self.casedAsteroids = asteroids.near_earth_objects
                print(self.casedAsteroids.count)
                self.asteroids = self.separatot(for: self.casedAsteroids)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func separatot(for dictionary: [String: [Asteroid]]) -> [Asteroid] {
        var count: [Asteroid] = []
        for (_, array) in dictionary {
            for ast in array {
                count.append(ast)
            }
        }
        return count
    }
}

