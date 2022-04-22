//
//  AsteroidViewCell.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 18.04.2022.
//

import UIKit

class AsteroidViewCell: UICollectionViewCell {
    
    var astro: Asteroid? = nil
    var chos = false
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var backgroungView: UIImageView!
    @IBOutlet var propertiesLabel: UILabel!
    @IBOutlet var diagnosisLabel: UILabel!
    
    @IBOutlet var asteroidImage: UIImageView!
    
    private func setImage(size: Int) {
        if size < 100 {
            asteroidImage.image = UIImage(named: "lowAstra")
        } else if size < 500 {
            asteroidImage.image = UIImage(named: "mediumAstra")
        } else {
            asteroidImage.image = UIImage(named: "bigAstra")
        }
    }
    
    
    func setColor(hazard: Bool) {
        switch hazard {
        case true:
            let gradient = CAGradientLayer()
            gradient.frame = backgroungView.bounds
            gradient.startPoint = CGPoint.zero
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.colors = [UIColor(red: 1, green: 0.694, blue: 0.6, alpha: 1).cgColor,
                               UIColor(red: 1, green: 0.031, blue: 0.267, alpha: 1).cgColor]
            backgroungView.layer.insertSublayer(gradient, at: 0)
        case false:
            let gradient = CAGradientLayer()
            gradient.frame = backgroungView.bounds
            gradient.startPoint = CGPoint.zero
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.colors = [
                UIColor(red: 0.811, green: 0.952, blue: 0.491, alpha: 1).cgColor,
                UIColor(red: 0.492, green: 0.908, blue: 0.549, alpha: 1).cgColor
              ]
            backgroungView.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    func configuration(with asteroid: Asteroid, and kmDistance: Bool) {
        let distance = kmDistance ? asteroid.close_approach_data[0].miss_distance.kilometers :
        asteroid.close_approach_data[0].miss_distance.lunar
        guard let distanceDouble = Double(distance) else {return}
        let diametr = (asteroid.estimated_diameter.meters.estimated_diameter_max + asteroid.estimated_diameter.meters.estimated_diameter_min)/2
        
        setImage(size: Int(diametr))
        
        nameLabel.text = asteroid.name
        propertiesLabel.text =
        """
        Диаметр: \(String(format: "%.0f",diametr)) м
        Подлетает \(asteroid.close_approach_data[0].close_approach_date)
        на расстояние \(String(format: "%.0f",distanceDouble)) \(kmDistance ? "км"
        : "лунных орбит")
        """
        diagnosisLabel.text = "\(asteroid.is_potentially_hazardous_asteroid ? "Опасен" : "Не опасен")"
        if asteroid.is_potentially_hazardous_asteroid {
            diagnosisLabel.textColor = .red
        }
        asteroidImage.contentScaleFactor = 2.0
        asteroidImage.sizeThatFits(CGSize(width: 122, height: 124))
    }
    
    @IBAction func destroyButtonPressed(_ sender: UIButton) {
        switch chos {
        case true:
            chos = true
        case false:
            guard let astro = astro else {return}
            ChosenAsteroid.shared.addNewAsterroid(astr: astro)
            print(1)
            sender.setTitle("DONE", for: .normal)
            chos = true
        }
    }
}
