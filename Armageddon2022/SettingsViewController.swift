//
//  SettingsViewController.swift
//  Armageddon2022
//
//  Created by Руслан Штыбаев on 21.04.2022.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var kmDistance = true
    var dangerous = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRes", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Ед. изм. расстояний"
            let customSC = UISegmentedControl(items: ["км", "лун. орб."])
            customSC.selectedSegmentIndex = 0
            customSC.layer.cornerRadius = 5.0  // Don't let background bleed
            customSC.backgroundColor = .lightGray
            customSC.tintColor = .white

                  // Add target action method
            customSC.addTarget(self, action: #selector(switching), for: .valueChanged)
            cell.accessoryView = customSC
        default:
            cell.textLabel?.text = "Показывать только опасные"
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(false, animated: true)
            //switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(switching), for: .valueChanged)
            cell.accessoryView = switchView
        }

        return cell
    }
    
    @objc func changeColor(sender: UISegmentedControl) {
          switch sender.selectedSegmentIndex {
          case 1:
              dangerous = true
          case 2:
              dangerous = false
          default:
              dangerous.toggle()
          }
      }
    
    
    @objc private func switching() {
        kmDistance.toggle()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
