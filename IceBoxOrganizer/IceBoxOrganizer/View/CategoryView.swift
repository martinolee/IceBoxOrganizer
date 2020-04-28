//
//  CategoryView.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class CategoryView: UIView {
  
  // MARK: - Properties
  
  var delegate: CategoryViewDelegate?
  
  private var categoryCollectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.headerReferenceSize = CGSize(width: 60, height: 40)
    layout.sectionHeadersPinToVisibleBounds = true
    return layout
  }()
  
  private lazy var categoryCollectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: self.frame,
      collectionViewLayout: categoryCollectionViewFlowLayout
    )
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    collectionView.register(
      MaterialsInIceBoxCollectionViewCell.self,
      forCellWithReuseIdentifier: MaterialsInIceBoxCollectionViewCell.identifier
    )
    
    collectionView.register(
      CategoryCollectionHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: CategoryCollectionHeaderView.identifier
    )
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.backgroundColor = .systemBackground
    
    return collectionView
  }()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
    setCategoryCollectionFlowLayout()
    setupCategoryCollectionViewAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  
  private func configureView() {
    self.backgroundColor = .systemBackground
  }
  
  // MARK: - Setup UI
  
  private func setupCategoryCollectionViewAutoLayout() {
    self.addSubview(categoryCollectionView)
    
    NSLayoutConstraint.activate([
      categoryCollectionView.topAnchor     .constraint(equalTo: self.topAnchor),
      categoryCollectionView.leadingAnchor .constraint(equalTo: self.leadingAnchor),
      categoryCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      categoryCollectionView.bottomAnchor  .constraint(equalTo: self.bottomAnchor),
    ])
  }
  
  func setCategoryCollectionFlowLayout() {
    let itemsInLine: CGFloat = 5
    let linesOnScreen: CGFloat = 6
    let singleItemSpacing: CGFloat = 10.0
    let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    let itemSpacing = singleItemSpacing * (itemsInLine - 1)
    let horizontalInset = edgeInsets.left + edgeInsets.right
    let verticalInset = edgeInsets.top + edgeInsets.bottom + safeAreaInsets.top + safeAreaInsets.bottom
    let horizontalSpacing = itemSpacing + horizontalInset
    let verticalSpacing = itemSpacing + verticalInset
    
    let contentWidth = UIScreen.main.bounds.width - horizontalSpacing
    let contentHeight = UIScreen.main.bounds.height - verticalSpacing
    let width = contentWidth / itemsInLine
    let height = contentHeight / linesOnScreen
    let itemSize = CGSize(width: width.rounded(.down), height: height.rounded(.down))
    
    categoryCollectionViewFlowLayout.minimumLineSpacing = singleItemSpacing
    categoryCollectionViewFlowLayout.minimumInteritemSpacing = singleItemSpacing
    categoryCollectionViewFlowLayout.sectionInset = edgeInsets
    
    categoryCollectionViewFlowLayout.itemSize = itemSize
  }
  
}

extension CategoryView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    delegate?.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath) ?? UICollectionReusableView()
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    delegate?.numberOfSections(in: collectionView) ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    delegate?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    delegate?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
  } 
  
}

extension CategoryView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
  }
}
