//
//  TSSWaterCollectionFlowLayout.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 10/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

@objc public protocol TSSWaterCollectionFlowLayoutDelegate: NSObjectProtocol {
    // 必选delegate实现
    /// collectionItem高度
    func TSSWater_heightForRowAtIndexPath(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat
    
    // 可选delegate实现
    /// 每个section 列数（默认2列）
    @objc optional func TSSWater_columnNumber(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> Int
    
    /// header高度（默认为zero）
    @objc optional func TSSWater_referenceSizeForHeader(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGSize
    
    /// footer高度（默认为zero）
    @objc optional func TSSWater_referenceSizeForFooter(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGSize
    
    /// 每个section 边距（默认为zero）
    @objc optional func TSSWater_insetForSection(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> UIEdgeInsets
    
    /// 每个section item上下间距（默认为0）
    @objc optional func TSSWater_lineSpacing(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGFloat
    
    /// 每个section item左右间距（默认为0）
    @objc optional func TSSWater_interitemSpacing(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGFloat
    
    /// section header与上个section footer间距（默认为0）
    @objc optional func TSSWater_spacingWithLastSection(collectionView collection: UICollectionView, layout: TSSWaterCollectionFlowLayout, section: Int) -> CGFloat
}

open class TSSWaterCollectionFlowLayout: UICollectionViewFlowLayout {
    public weak var delegate: TSSWaterCollectionFlowLayoutDelegate?
    
    private var sectionInsets: UIEdgeInsets = .zero
    private var columnCount: Int = 2
    private var lineSpacing: CGFloat = 0
    private var interitemSpacing: CGFloat = 0
    private var headerSize: CGSize = .zero
    private var footerSize: CGSize = .zero
    
    //存放attribute的数组
    private var attrsArray: [UICollectionViewLayoutAttributes] = []
    //存放每个section中各个列的最后一个高度
    private var columnHeights: [CGFloat] = []
    //collectionView的Content的高度
    private var contentHeight: CGFloat = 0
    //记录上个section高度最高一列的高度
    private var lastContentHeight: CGFloat = 0
    //每个section的header与上个section的footer距离
    private var spacingWithLastSection: CGFloat = 0
    
    
    open override func prepare() {
        super.prepare()
        //MARK: 重置部分属性
        self.contentHeight = 0
        self.lastContentHeight = 0
        self.spacingWithLastSection = 0
        self.lineSpacing = 0
        self.sectionInsets = .zero
        self.headerSize = .zero
        self.footerSize = .zero
        self.columnHeights.removeAll()
        self.attrsArray.removeAll()
        //MARK: 获取当前collectionView中的Section个数
        let sectionCount = self.collectionView!.numberOfSections
        // 遍历section
        for idx in 0..<sectionCount {
            //MARK: 获取每个Section中的indexPath
            let indexPath = IndexPath(item: 0, section: idx)
            //MARK: 根据协议获取每个分组中设置的瀑布流列数 默认2列
            if let columnCount = self.delegate?.TSSWater_columnNumber?(collectionView: self.collectionView!, layout: self, section: indexPath.section) {
                self.columnCount = columnCount
            }
            //MARK: 获取协议中设置的每个section 中的 间隙 上下左右 默认.zero
            if let inset = self.delegate?.TSSWater_insetForSection?(collectionView: self.collectionView!, layout: self, section: indexPath.section) {
                self.sectionInsets = inset
            }
            //MARK: 获取协议中设置的每个section header 与下个footer之间的间隙 默认0
            if let spacingLastSection = self.delegate?.TSSWater_spacingWithLastSection?(collectionView: self.collectionView!, layout: self, section: indexPath.section) {
                self.spacingWithLastSection = spacingLastSection
            }

            //MARK: 获取每个分组中的item 个数
            let itemCount = self.collectionView!.numberOfItems(inSection: idx)
            //MARK: header
            let headerAttri = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)
            if let header = headerAttri {
                self.attrsArray.append(header)
                self.columnHeights.removeAll()
            }
            self.lastContentHeight = self.contentHeight
            // 初始化区 y值
            for _ in 0..<self.columnCount {
                self.columnHeights.append(self.contentHeight)
            }
            // 遍历item
            for item in 0..<itemCount {
                let indexPat = IndexPath(item: item, section: idx)
                let attri = self.layoutAttributesForItem(at: indexPat)
                if let attri = attri {
                    self.attrsArray.append(attri)
                }
            }
            
            // 初始化footer
            let footerAttri = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath)
            if let footer = footerAttri {
                self.attrsArray.append(footer)
            }
        }
    }
    //MARK: 返回当前自定义的  layoutAttributes
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrsArray
    }
    //MARK: 根据indexPath重置item布局属性
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //MARK: 获取协议中每个Section中的列数
        if let column = self.delegate?.TSSWater_columnNumber?(collectionView: self.collectionView!, layout: self, section: indexPath.section) {
            self.columnCount = column
        }
        //MARK: 获取协议中自定义的 每个section的 item 行间距
        if let lineSpacing = self.delegate?.TSSWater_lineSpacing?(collectionView: self.collectionView!, layout: self, section: indexPath.section) {
            self.lineSpacing = lineSpacing
        }
        //MARK: 获取协议中自定义的 每个section的 item 之间的间距
        if let interitem = self.delegate?.TSSWater_interitemSpacing?(collectionView: self.collectionView!, layout: self, section: indexPath.section) {
            self.interitemSpacing = interitem
        }
        
        let attri = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let weight = self.collectionView!.frame.size.width
        let itemSpacing = CGFloat(self.columnCount - 1) * self.interitemSpacing
        let allWeight = weight - self.sectionInsets.left - self.sectionInsets.right - itemSpacing
        let cellWeight = allWeight / CGFloat(self.columnCount)
        let cellHeight: CGFloat = (self.delegate?.TSSWater_heightForRowAtIndexPath(collectionView: self.collectionView!, layout: self, indexPath: indexPath, itemWidth: cellWeight))!
        //      let cellHeight: CGFloat =  50
        var tmpMinColumn = 0
        var minColumnHeight = self.columnHeights[0]
        for i in 0..<self.columnCount {
            let columnH = self.columnHeights[i]
            if minColumnHeight > columnH {
                minColumnHeight = columnH
                tmpMinColumn = i
            }
        }
        let cellX = self.sectionInsets.left + CGFloat(tmpMinColumn) * (cellWeight + self.interitemSpacing)
        var cellY: CGFloat = 0
        cellY = minColumnHeight
        if cellY != self.lastContentHeight {
            cellY += self.lineSpacing
        }
        
        if self.contentHeight < minColumnHeight {
            self.contentHeight = minColumnHeight
        }
        
        attri.frame = CGRect(x: cellX, y: cellY, width: cellWeight, height: cellHeight)
        self.columnHeights[tmpMinColumn] = attri.frame.maxY
        //取最大的
        for i in 0..<self.columnHeights.count {
            if self.contentHeight < self.columnHeights[i] {
                self.contentHeight = self.columnHeights[i]
            }
        }
        
        return attri
    }
    open  override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attri = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        if elementKind == UICollectionView.elementKindSectionHeader {
            if let headerSize = self.delegate?.TSSWater_referenceSizeForHeader?(collectionView: self.collectionView!, layout: self, section: indexPath.section) {
                self.headerSize = headerSize
            }
            self.contentHeight += self.spacingWithLastSection
            attri.frame = CGRect(x: 0, y: self.contentHeight, width: self.headerSize.width, height: self.headerSize.height)
            self.contentHeight += self.headerSize.height
            self.contentHeight += self.sectionInsets.top
        } else if elementKind == UICollectionView.elementKindSectionFooter {
            if let footerSize = self.delegate?.TSSWater_referenceSizeForFooter?(collectionView: self.collectionView!, layout: self, section: indexPath.section) {
                self.footerSize = footerSize
            }
            self.contentHeight += self.sectionInsets.bottom
            attri.frame = CGRect(x: 0, y: self.contentHeight, width: self.footerSize.width, height: self.footerSize.height)
            self.contentHeight += self.footerSize.height
        }
        return attri
    }
    //MARK: 重置collectionView的高度
    open  override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView!.frame.size.width, height: self.contentHeight)
    }
}
