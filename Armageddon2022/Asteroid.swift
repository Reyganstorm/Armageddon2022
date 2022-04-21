//
//  Asteroid.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 18.04.2022.
//

import Foundation

// MARK: - Nasa
struct Nasa: Decodable {
    let near_earth_objects: [String: [Asteroid]]
}

// MARK: - NearEarthObject
struct Asteroid: Decodable {
    let links: LinkOfAsteroid
    let id: String
    let name: String

    let estimated_diameter: Diameter
    
    let is_potentially_hazardous_asteroid: Bool
    
    let close_approach_data: [CloseApproachDatum]
    let is_sentry_object: Bool
}

// MARK: - CloseApproachDatum
struct CloseApproachDatum: Decodable {
    let close_approach_date: String
    let close_approach_date_full: String
    
    // Это можно вставить в подробную информацию
    let relative_velocity: RelativeVelocity
    
    let miss_distance: MissDistance
}

// MARK: - MissDistance
struct MissDistance: Decodable {
    let lunar: String
    let kilometers: String
}


// MARK: - RelativeVelocity
struct RelativeVelocity: Decodable {
    let kilometers_per_second: String
    let kilometers_per_hour: String
    let miles_per_hour: String
}

// MARK: - Diameter
struct Diameter: Decodable {
    let meters: Feet
}

// MARK: - Feet
struct Feet: Decodable {
    let estimated_diameter_min, estimated_diameter_max: Double
}

// MARK: - LinkOfAsteroid
struct LinkOfAsteroid: Decodable {
    let linksSelf: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}
