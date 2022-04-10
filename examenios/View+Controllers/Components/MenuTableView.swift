//
//  MenuTableView.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit

class MenuTableView: UITableView {
    enum MenuType: Int {
        case textField
        case selfie
        case graphics
    }
    
    var onPress: (MenuType) -> Void = { (_) in }
    var getText: (String) -> Void = { (_) in }
}

extension MenuTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = MenuType(rawValue: indexPath.row) else { return }
        
        switch type {
        case .selfie, .graphics:
            self.onPress(type)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MenuTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = MenuType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch type {
        case .textField:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.identifier, for: indexPath) as! TextFieldCell
            cell.delegate = self
            return cell
        case .selfie:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
            cell.textLabel?.text = "Selfie"
            cell.accessoryType = .disclosureIndicator
            return cell
        case .graphics:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
            cell.textLabel?.text = "Gráficas"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
}

extension MenuTableView: TextFieldCellDelegate {
    func getText(text: String) {
        self.getText(text)
    }
}
