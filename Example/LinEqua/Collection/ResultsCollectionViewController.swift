//
//  ResultsCollectionViewController.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 7/6/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

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
        let countGaussJordan = Data.shared.resultsGauss?.count ?? 0 
        return 1 + max(countGauss, countGaussJordan)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
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
            switch indexPath.row {
            case 0:
                return "Gauss"
            case 1:
                return "Gauss Jordan"
            case 2:
                return "△"
            default:
                return ""
            }
        }
        
        // values
        guard let resGauss = Data.shared.resultsGauss?[indexPath.section - 1] else { return "" }
        guard let resGaussJordan = Data.shared.resultsGaussJordan?[indexPath.section - 1] else { return "" }
        
        switch indexPath.row {
        case 0:
            return "\(resGauss)"
        case 1:
            return "\(resGaussJordan)"
        case 2:
            return  String.init(format: "%.3f +e14", abs((resGaussJordan - resGauss) * 100_000_000_000_000))
        default:
            return ""
        }
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
