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
        let countGaussJordan =  0 // Data.shared.resultsGauss?.count ?? 0 // TODO 
        return max(countGauss, countGaussJordan)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionViewCell.identifier, for: indexPath) as? SampleCollectionViewCell else {
            fatalError("Unexpected index path")
        }
    
        cell.valueLabel.text = valueForIndexPath(indexPath)
        return cell
    }

    func valueForIndexPath(_ indexPath: IndexPath) -> String {
        guard let res = Data.shared.resultsGauss?[indexPath.section] else { return "" }
        return "\(res)"
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
