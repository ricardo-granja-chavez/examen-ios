//
//  ChartDataGroupCell.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 10/04/22.
//

import UIKit

class ChartDataGroupCell: UITableViewCell {

    static let identifier = "ChartDataGroupCell"
    
    @IBOutlet weak var chartDataCollectionView: ChartDataCollectionView!
    @IBOutlet weak var chartDataLayout: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(colors: ColorListViewModel, chartDataList: ChartDataListViewModel) {
        chartDataCollectionView.register(UINib(nibName: ChartDataCell.identifier, bundle: nil), forCellWithReuseIdentifier: ChartDataCell.identifier)
        chartDataCollectionView.delegate = chartDataCollectionView
        chartDataCollectionView.dataSource = chartDataCollectionView
        chartDataCollectionView.colors = colors
        chartDataCollectionView.collection = chartDataList
        
        chartDataLayout.constant = 50 * ceil(Double(chartDataList.count) / 2.0)
    }
    
}
