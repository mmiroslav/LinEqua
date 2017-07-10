//
//  MatrixCollectionViewController.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 7/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MatrixCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(UINib(nibName: "SampleCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: SampleCollectionViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let count = Data.shared.matrix?.originalValue?.count else { return 0 }
        return count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = Data.shared.matrix?.originalValue?[section].count else { return 0 }
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionViewCell.identifier, for: indexPath) as? SampleCollectionViewCell else {
            fatalError("Unexpected index path")
        }
    
        
        if let value = Data.shared.matrix?.originalValue?[indexPath.section][indexPath.row] {
            cell.valueLabel.text = String(format: "%.1f", value)
        }
        
        return cell
    }
}
