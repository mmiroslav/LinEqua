//
//  ResultsCollectionViewController.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 7/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ResultsCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(UINib.init(nibName: "SampleCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: SampleCollectionViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        let countGauss = Data.shared.resultsGauss?.count ?? 0
        let countGaussJordan = Data.shared.resultsGaussJordan?.count ?? 0
        let maxVal = max(countGauss, countGaussJordan)
        return 1 + maxVal
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var noOfRows = 0
        if Data.shared.resultsGauss != nil {
            noOfRows += 1
        }
        if Data.shared.resultsGaussJordan != nil {
            noOfRows += 1
        }
        if noOfRows == 2 { // if compareable
            noOfRows += 1
        }
        return noOfRows
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionViewCell.identifier, for: indexPath) as? SampleCollectionViewCell else {
            fatalError("Unexpected index path")
        }
    
        cell.valueLabel.text = valueForIndexPath(indexPath)
        return cell
    }

    func valueForIndexPath(_ indexPath: IndexPath) -> String {
        // title
        if indexPath.section == 0 {
            return titlesArr[indexPath.row]
        }
        
        // values
        var gaussResult = 0.0
        var gaussJordanResult = 0.0
        var resultArr = [String]()
        
        if Data.shared.resultsGauss != nil {
            gaussResult = Data.shared.resultsGauss?[indexPath.section - 1]  ?? 0.0
            resultArr.append("\(gaussResult)")
        }
        if Data.shared.resultsGaussJordan != nil {
            gaussJordanResult = Data.shared.resultsGaussJordan?[indexPath.section - 1] ?? 0.0
            resultArr.append("\(gaussJordanResult)")
        }
        if resultArr.count == 2 { // if compareable
            resultArr.append(String.init(format: "%.3f +e14", abs((gaussJordanResult - gaussResult) * 100_000_000_000_000)))
        }

        return resultArr[indexPath.row]
    }
    
    
    var titlesArr: [String] {
        var titleArr = [String]()
        if Data.shared.resultsGauss != nil {
            titleArr.append("Gauss")
            }
        if Data.shared.resultsGaussJordan != nil {
            titleArr.append("Gauss Jordan")
            }
        if titleArr.count == 2 { // if compareable
            titleArr.append("△")
        }
        return titleArr
    }
}


extension ResultsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfCollumns = 0
        if collectionView.numberOfSections > 0 {
            numOfCollumns = collectionView.numberOfItems(inSection: 0)
        }
        let screenWidth = collectionView.frame.size.width
        return CGSize(width: screenWidth/CGFloat(numOfCollumns), height: 50.0)
    }
    
}
