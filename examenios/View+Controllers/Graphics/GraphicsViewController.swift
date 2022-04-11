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
        questionsTableView.dataSource = questionsTableView
        questionsTableView.separatorStyle = .none
        
        getQuestions()
        observeColor()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let appColor = Constants.shared.appColor {
            self.view.backgroundColor = UIColor(hexString: appColor)
        }
    }
    
    func getQuestions() {
        SVProgressHUD.show()
        QuestionService().getQuestions { [weak self] (result) in
            SVProgressHUD.dismiss()
            
            switch result {
            case .success(let content):
                DispatchQueue.main.async {
                    self?.questionContentViewModel = QuestionContentViewModel(content: content)
                    self?.questionsTableView.colors = self?.questionContentViewModel.colors
                    self?.questionsTableView.collection = self?.questionContentViewModel
                    self?.questionsTableView.reloadData()
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                AlertController.shared.show(controller: self!, title: "Error", message: "Algo salió mal, por favor inténtalo más tarde") {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func observeColor() {
        ColorService().observeColor { [weak self] (result) in
            switch result {
            case.success(_):
                DispatchQueue.main.async {
                    if let appColor = Constants.shared.appColor {
                        self?.view.backgroundColor = UIColor(hexString: appColor)
                    }
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                AlertController.shared.show(controller: self!, title: "Error", message: "No se pudo intercambiar el color, por favor inténtalo más tarde")
            }
        }
    }
}
