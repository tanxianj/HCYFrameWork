//
//  CollectionHeaderAutoLayoutViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 23/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork

class CollectionHeaderAutoLayoutViewController: TSSBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var showAll:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10.scale()
        layout.minimumInteritemSpacing = 10.scale()
        layout.sectionInset = .init(top: 10.scale(), left: 10.scale(), bottom: 10.scale(), right: 10.scale())
        layout.itemSize = CGSize(width: (TSSScreenW - 30.scale())/2, height: 100.scale())
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.register(UINib.init(nibName: "TestCollectionheaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TestCollectionheaderView")
        
        collectionView.register(UINib.init(nibName: "TestCollectionheaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TestCollectionheaderView")
        // Do any additional setup after loading the view.

    }

    override func setupNavigationItems() {
        title = "header自适应"
    }

}
extension CollectionHeaderAutoLayoutViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .arc4Color()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Get the view for the first header
            let indexPath = IndexPath(row: 0, section: section)
            let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

            // Use this view to calculate the optimal size based on the collection view's width
            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                      withHorizontalFittingPriority: .required, // Width is fixed
                                                      verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TestCollectionheaderView", for: indexPath) as! TestCollectionheaderView
            header.delegate = self
            header.readMoreBtn.isSelected = showAll
            header.testLab.numberOfLines = showAll ? 0 : 3
            header.testLab.textColor = showAll ? .red : .black
            return header
        }else{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TestCollectionheaderView", for: indexPath)
            return footer
        }
    }
}
extension CollectionHeaderAutoLayoutViewController:TestCollectionheaderViewDelegate{
    func cellReadMoreBtnAction(isSelected: Bool) {
        showAll = isSelected
        collectionView.reloadData()
    }
}
