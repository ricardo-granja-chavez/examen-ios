//
//  TextFieldCell.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit

protocol TextFieldCellDelegate: AnyObject {
    func getText(text: String)
}

class TextFieldCell: UITableViewCell {

    static let identifier = "TextFieldCell"
    weak var delegate: TextFieldCellDelegate?
    
    @IBOutlet weak var inputTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        inputTextField.delegate = self
    }
    
    @IBAction func textEditing(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.delegate?.getText(text: text)
    }
}

extension TextFieldCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        } catch {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
