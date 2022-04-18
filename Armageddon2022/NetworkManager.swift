//
//  NetworkManager.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 18.04.2022.
//

import Foundation

enum Links: String, CaseIterable {
    case allAsteroids = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2022-04-18&end_date=2022-04-19&api_key=FbmCl54hDp98EmrxHMuDTRLZPqcCTDCPzSh35fNf"
    case forMore
    
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    init() {}
    
    func fetch(from url: String, completion: @escaping(Result<Nasa, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let type = try JSONDecoder().decode(Nasa.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
