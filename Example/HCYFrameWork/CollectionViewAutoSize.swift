//
//  CollectionVIewAutoSize.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 10/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class CollectionViewAutoSize: TSSBaseCollectionViewController {
    
    let dataSource = ["123123123123123123123123123123123123123123123123123123123123123123",
                      "123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123",
                      "123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123",
                      "123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123",
                      "123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123",
                      "123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123123"]
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.minimumLineSpacing = 10.scale()
        layout.minimumInteritemSpacing = 10.scale()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        collectionView.register(UINib(nibName: "AutoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AutoCollectionViewCell")
        collectionView.register(AutoTwoCollectionViewCell.self, forCellWithReuseIdentifier: AutoTwoCollectionViewCell.tss_Identifier())
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
            }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CollectionViewAutoSize:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AutoCollectionViewCell", for: indexPath) as!  AutoCollectionViewCell
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AutoTwoCollectionViewCell.Identifier(), for: indexPath) as! AutoTwoCollectionViewCell
        cell.titleLab.text = dataSource[indexPath.row]
        return cell
    }
}
