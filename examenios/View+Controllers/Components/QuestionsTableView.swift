//
//  QuestionsTableView.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit
import Foundation

class QuestionsTableView: UITableView {
    var colors: ColorListViewModel!
    var collection: QuestionContentViewModel!
}

extension QuestionsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { self.collection == nil ? 0 : self.collection.questions.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.identifier, for: indexPath) as! QuestionCell
        let question = self.collection.questions.questionForIndex(index)
        cell.configure(colors: self.colors, question: question)
        return cell
    }
}
