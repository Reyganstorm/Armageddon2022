//
//  DeletedTableViewController.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 22.04.2022.
//

import UIKit


class DeletedTableViewController: UITableViewController {
    
    var asteroids = ChosenAsteroid.shared.chosenAsteroid

    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        asteroids.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForTrash", for: indexPath)
        
        let astr = asteroids[indexPath.row]
            var content = cell.defaultContentConfiguration()
            
            
            content.text = "\(astr.name)"
                
            cell.contentConfiguration = content
        
        return cell
    }

}
 
