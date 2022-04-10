//
//  ChartDataCell.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 10/04/22.
//

import UIKit

class ChartDataCell: UICollectionViewCell {

    static let identifier = "ChartDataCell"
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var chartDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(color: UIColor, chartData: ChartDataViewModel) {
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = colorView.frame.height / 2
        
        chartDataLabel.text = "\(chartData.text) \(chartData.percetnage)%"
    }
}
