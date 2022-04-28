//
//  SettingsViewController.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 21.04.2022.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var kmDistance = UserDefaults.standard.bool(forKey: "kmDist")
    var dangerous = UserDefaults.standard.bool(forKey: "astroHazard")


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRes", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Ед. изм. расстояний"
            let customSC = UISegmentedControl(items: ["км", "лун. орб."])
            customSC.selectedSegmentIndex = kmDistance ? 0 : 1
            customSC.layer.cornerRadius = 5.0
            customSC.backgroundColor = .lightGray
            customSC.tintColor = .white
            customSC.addTarget(self, action: #selector(changeDistance), for: .valueChanged)
            cell.accessoryView = customSC
        default:
            cell.textLabel?.text = "Показывать только опасные"
            let switchView = UISwitch()
            switchView.setOn(dangerous ? true : false, animated: true)
            //switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(switching), for: .valueChanged)
            cell.accessoryView = switchView
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func changeDistance() {
        switch kmDistance {
        case true:
            UserDefaults.standard.set(false, forKey: "kmDist")
        case false:
            UserDefaults.standard.set(true, forKey: "kmDist")
        }
      }
    
    @objc private func switching() {
        switch dangerous {
        case true:
            UserDefaults.standard.set(false, forKey: "astroHazard")
        case false:
            UserDefaults.standard.set(true, forKey: "astroHazard")
        }
    }
    
    

    
    

}
