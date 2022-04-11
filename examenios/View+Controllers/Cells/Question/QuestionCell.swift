//
//  QuestionCell.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit
import Charts

class QuestionCell: UITableViewCell {

    static let identifier = "QuestionCell"

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var pieView: PieChartView!
    
    @IBOutlet weak var chartDataCollectionView: ChartDataCollectionView!
    @IBOutlet weak var chartDataLayout: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(colors: ColorListViewModel, question: QuestionViewModel)  {
        questionLabel.text = question.text
        
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = false
        pieView.rotationAngle = 0
        pieView.rotationEnabled = false
        pieView.isUserInteractionEnabled = false
        pieView.noDataText = ""
        
        var entries: [PieChartDataEntry] = []
        for index in 0...question.chartData.count - 1 {
            entries.append(PieChartDataEntry(value: Double(question.chartData.chartDataForIndex(index).percetnage)))
        }
        
        let dataSet = PieChartDataSet(entries: entries)
        
        var nsColors: [NSUIColor] = []
        for index in 0...colors.count - 1 {
            nsColors.append(NSUIColor(hexString: colors.colorHexForIndex(index)))
        }
        
        dataSet.colors = nsColors
        dataSet.drawValuesEnabled = false
        
        pieView.data = PieChartData(dataSet: dataSet)
        
        chartDataCollectionView.register(UINib(nibName: ChartDataCell.identifier, bundle: nil), forCellWithReuseIdentifier: ChartDataCell.identifier)
        chartDataCollectionView.delegate = chartDataCollectionView
        chartDataCollectionView.dataSource = chartDataCollectionView
        chartDataCollectionView.colors = colors
        chartDataCollectionView.collection = question.chartData
        
        chartDataLayout.constant = 50 * ceil(Double(question.chartData.count) / 2.0)
    }
    
}
