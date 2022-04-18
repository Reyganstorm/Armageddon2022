//
//  AsteroidViewCell.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 18.04.2022.
//

import UIKit

class AsteroidViewCell: UICollectionViewCell {
    
    @IBOutlet var asteroidImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var backgroungView: UIImageView!
    
    @IBOutlet var propertiesLabel: UILabel!
    
    @IBOutlet var diagnosisLabel: UILabel!
    
    @IBAction func destroyTheAsteroid(_ sender: UIButton) {
    }
    

    func configuration(with asteroid: Asteroid) {
        nameLabel.text = asteroid.name
        
        asteroidImage.contentScaleFactor = 2.0
        asteroidImage.sizeThatFits(CGSize(width: 122, height: 124))
    }
    

}
