//
//  GraphicsViewController.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit
import SVProgressHUD

class GraphicsViewController: UIViewController {

    @IBOutlet weak var questionsTableView: QuestionsTableView!
    
    private var questionContentViewModel: QuestionContentViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionsTableView.register(UINib(nibName: QuestionCell.identifier, bundle: nil), forCellReuseIdentifier: QuestionCell.identifier)
        questionsTableView.register(UINib(nibName: ChartDataGroupCell.identifier, bundle: nil), forCellReuseIdentifier: ChartDataGroupCell.identifier)
        questionsTableView.dataSource = questionsTableView
        questionsTableView.separatorStyle = .none
        
        getQuestions()
    }

    func getQuestions() {
        SVProgressHUD.show()
        QuestionService().getQuestions { (result) in
            SVProgressHUD.dismiss()
            
            switch result {
            case .success(let content):
                DispatchQueue.main.async {
                    self.questionContentViewModel = QuestionContentViewModel(content: content)
                    self.questionsTableView.colors = self.questionContentViewModel.colors
                    self.questionsTableView.collection = self.questionContentViewModel
                    self.questionsTableView.reloadData()
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
}
