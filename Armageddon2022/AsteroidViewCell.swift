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
    
    @IBOutlet var asteroidImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var backgroungView: UIImageView!
    @IBOutlet var propertiesLabel: UILabel!
    @IBOutlet var diagnosisLabel: UILabel!
    
    

    func configuration(with asteroid: Asteroid, and kmDistance: Bool) {
        let distance = kmDistance ? asteroid.close_approach_data[0].miss_distance.kilometers :
        asteroid.close_approach_data[0].miss_distance.lunar
        guard let distanceDouble = Double(distance) else {return}
        
    
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd"
//        dateFormatterGet.locale = Locale(identifier: "ru_RU")
//        let strDate = dateFormatterGet.date(from: asteroid.close_approach_data[0].close_approach_date)
        
        let diametr = (asteroid.estimated_diameter.meters.estimated_diameter_max + asteroid.estimated_diameter.meters.estimated_diameter_min)/2
        
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
    
    func takeAstro(asteroid: Asteroid) -> Asteroid {
        return asteroid
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
