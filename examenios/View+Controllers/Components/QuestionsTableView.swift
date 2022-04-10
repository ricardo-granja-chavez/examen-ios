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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { self.collection == nil ? 0 : self.collection.questions.count * 2 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row

        if (index % 2) == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.identifier, for: indexPath) as! QuestionCell
            let newindex = index / 2
            let question = self.collection.questions.questionForIndex(newindex)
            cell.configure(colors: self.colors, question: question)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChartDataGroupCell.identifier, for: indexPath) as! ChartDataGroupCell
            let newindex = index / 2
            let question = self.collection.questions.questionForIndex(newindex)
            cell.configure(colors: self.colors, chartDataList: question.chartData)
            return cell
        }
    }
}
