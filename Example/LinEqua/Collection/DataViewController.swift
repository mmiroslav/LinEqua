//
//  DataViewController.swift
//  LinEqua
//
//  Created by Miroslav Milivojevic on 7/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib.init(nibName: "SampleCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: SampleCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        scrollView.horizo
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = collectionView.frame.size
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}

extension DataViewController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 30
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionViewCell.identifier, for: indexPath) as? SampleCollectionViewCell else {
            fatalError("Unexpected index path")
        }
        
        // Configure the cell
        cell.valueLabel.text = "\(indexPath.section):\(indexPath.row)"
        return cell
    }

}
