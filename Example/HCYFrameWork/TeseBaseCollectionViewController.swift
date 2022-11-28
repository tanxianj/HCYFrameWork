//
//  TeseBaseCollectionViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 10/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class TeseBaseCollectionViewController: TSSBaseCollectionViewController {
    override func tss_baseViewDelegateisEnabled() -> Bool {
        true
    }
    var viewModel = TeseBaseCollectionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let date  = Date().toFormat("yyyy/MM/dd HH:mm EEEE a")
//        print("date is \(date)")
        
//        let layout = TSSWaterCollectionFlowLayout()
//        layout.delegate = self
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-30.scale()) / 2.0, height: 100.scale())
        layout.minimumInteritemSpacing = 10.scale()
        layout.minimumLineSpacing = 10.scale()
        layout.sectionInset = UIEdgeInsets(top: 10.scale(), left: 10.scale(), bottom: 10.scale(), right: 10.scale())
//        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "tssCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.register(UINib(nibName: "TestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TestCollectionViewCell.tss_Identifier())
        let testView = UIView()
        testView.backgroundColor = .gray
        topView.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10.scale(), left: 10.scale(), bottom: 10.scale(), right: 10.scale()))
            make.height.equalTo(100.scale())
        }
        
        let v_layout = UICollectionViewFlowLayout()
        v_layout.itemSize = CGSize(width: (TSSScreenW-30.scale()) / 2.0, height: 100.scale())
        v_layout.minimumInteritemSpacing = 10.scale()
        v_layout.minimumLineSpacing = 10.scale()
        v_layout.sectionInset = UIEdgeInsets(top: 10.scale(), left: 10.scale(), bottom: 10.scale(), right: 10.scale())
        
        
        let h_layout = UICollectionViewFlowLayout()
        h_layout.itemSize = CGSize(width: (TSSScreenH-50.scale()) / 4.0, height: 100.scale())
        h_layout.minimumInteritemSpacing = 10.scale()
        h_layout.minimumLineSpacing = 10.scale()
        h_layout.sectionInset = UIEdgeInsets(top: 10.scale(), left: 10.scale(), bottom: 10.scale(), right: 10.scale())
        
        
 
        self.tss_FitLayoutWith(horizontalLayout: h_layout, verticalLayout: v_layout)
        
        viewModel.bind(self.collectionView)
        
    }
 

}
extension TeseBaseCollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath)
        cell.contentView.backgroundColor = .arc4Color()
        return cell
    }
    
    
}
extension TeseBaseCollectionViewController:TSSWaterCollectionFlowLayoutDelegate{
    func TSSWater_columnNumber(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> Int {
        switch section{
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 4
        default:
            return 3
        }
    }
    func TSSWater_heightForRowAtIndexPath(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat {
        let tmp = arc4random()%300
        return CGFloat(tmp)

//        switch tmp{
//        case 0:
//            return 100
//        case 1:
//            return 150
//        case 2:
//            return 200
//        default:
//            return 300
//        }
        
    }
    
    func TSSWater_lineSpacing(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGFloat {
        return 10.scale()
    }
    func TSSWater_spacingWithLastSection(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGFloat {
        10.scale()
    }
    func TSSWater_interitemSpacing(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGFloat {
        10.scale()
    }
    func TSSWater_referenceSizeForFooter(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGSize {
        return CGSize(width: TSSScreenW, height: 50)
    }
    func TSSWater_referenceSizeForHeader(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGSize {
        return CGSize(width: TSSScreenW, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            header.backgroundColor = .red
            return header
        }else{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            footer.backgroundColor = .blue
            return footer
        }
        
    }
    


}
