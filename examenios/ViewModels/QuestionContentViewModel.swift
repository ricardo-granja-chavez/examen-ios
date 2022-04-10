//
//  QuestionContentViewModel.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

//import Foundation
import UIKit

struct QuestionContentViewModel {
    private var content: QuestionContentModel!
    
    let colors: ColorListViewModel!
    var questions: QuestionListViewModel!
    
    init(content: QuestionContentModel) {
        self.content = content
        self.colors = ColorListViewModel(list: self.content.colors ?? [])
        self.questions = QuestionListViewModel(list: self.content.questions ?? [])
    }
}

struct ColorListViewModel {
    private var colors: [String] = []
    public var count: Int { self.colors.count }
    
    init(list: [String]) {
        self.colors = list
    }
    
    func colorForIndex(_ index: Int) -> UIColor { UIColor(hexString: self.colors[index]) }
    
    func colorHexForIndex(_ index: Int) -> String { self.colors[index] }
}

// MARK: - Question
struct QuestionViewModel {
    private var question: QuestionModel!
    
    var total: Int { self.question.total ?? -1 }
    var text: String { self.question.text ?? "" }
    var chartData: ChartDataListViewModel!
    
    init(question: QuestionModel) {
        self.question = question
        self.chartData = ChartDataListViewModel(list: self.question.chartData ?? [])
    }
}

struct QuestionListViewModel {
    private var questions: [QuestionModel] = []
    public var count: Int { self.questions.count }
    
    init(list: [QuestionModel]) {
        self.questions = list
    }
    
    func questionForIndex(_ index: Int) -> QuestionViewModel {
        QuestionViewModel(question: self.questions[index])
    }
    
}


// MARK: - ChartData
struct ChartDataViewModel {
    private let chartData: ChartDataModel!
    
    var text: String { self.chartData.text ?? "" }
    var percetnage: Int { self.chartData.percetnage ?? -1 }
    
    init(chartData: ChartDataModel) {
        self.chartData = chartData
    }
}

struct ChartDataListViewModel {
    private var chartDataList: [ChartDataModel] = []
    public var count: Int { self.chartDataList.count }
    
    init(list: [ChartDataModel]) {
        self.chartDataList = list
    }
    
    func chartDataForIndex(_ index: Int) -> ChartDataViewModel {
        ChartDataViewModel(chartData: self.chartDataList[index])
    }
    
}
