//
//  QuestionContentModel.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import Foundation

// MARK: - QuestionContent
struct QuestionContentModel: Codable {
    let colors: [String]?
    let questions: [QuestionModel]?
}

// MARK: - Question
struct QuestionModel: Codable {
    let total: Int?
    let text: String?
    let chartData: [ChartDataModel]?
}

// MARK: - ChartDatum
struct ChartDataModel: Codable {
    let text: String?
    let percetnage: Int?
}
