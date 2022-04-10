//
//  QuestionService.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import Foundation

class QuestionService {
    func getQuestions(completion: @escaping (Result<QuestionContentModel, APIError>) -> Void) {
        APIManager.shared.request(url: QuestionRouter.getQuestions.toRequest(), completion: completion)
    }
}
