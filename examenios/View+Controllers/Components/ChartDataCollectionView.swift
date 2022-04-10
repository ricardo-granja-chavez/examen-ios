//
//  ChartDataCollectionView.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 10/04/22.
//

import UIKit

class ChartDataCollectionView: UICollectionView {
    var colors: ColorListViewModel!
    var collection: ChartDataListViewModel!
}

extension ChartDataCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.bounds.width / 2, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 0 }
    
}

extension ChartDataCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { self.collection.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartDataCell.identifier, for: indexPath) as! ChartDataCell
        let chartData = self.collection.chartDataForIndex(indexPath.item)
        let color = self.colors.colorForIndex(indexPath.item)
        cell.configure(color: color, chartData: chartData)
        return cell
    }
}
