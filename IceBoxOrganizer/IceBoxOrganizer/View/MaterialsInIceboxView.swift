//
//  MaterielsInIceBoxView.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class MaterialsInIceboxView: UIView {
  
  // MARK: - Properties
  
  var delegate: MaterialsInIceBoxViewDelegate?
  
  private let addNewMaterialButton: UIButton = {
    let button = UIButton(type: .system)
    let plusImage = UIImage(systemName: "plus.square.fill")
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.setPreferredSymbolConfiguration(.init(pointSize: 30), forImageIn: .normal)
    button.setImage(plusImage, for: .normal)
    button.tintColor = ColorZip.ivory
    
    button.addTarget(self, action: #selector(whenDidAddNewMaterialButtonTouchUpInside(_:)), for: .touchUpInside)
    
    return button
  }()
  
  private let backButon: UIButton = {
    let button = UIButton(type: .system)
    let backImage = UIImage(systemName: "arrow.left")
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.setImage(backImage, for: .normal)
    button.setPreferredSymbolConfiguration(.init(pointSize: 30), forImageIn: .normal)
    button.tintColor = ColorZip.basicGreen
    button.addTarget(self, action: #selector(whenDidBackButonTouchUpInside(_:)), for: .touchUpInside)
    return button
  }()
  
  private let emptyImageView: UIImageView = {
    let emptyImageView = UIImageView()
    emptyImageView.image = UIImage(named: "empty")
    emptyImageView.translatesAutoresizingMaskIntoConstraints = false
    emptyImageView.contentMode = .scaleAspectFit
    return emptyImageView
  }()
  
  private var materialsCollectionViewFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    
    return layout
  }()
  
  private lazy var materialsCollectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: self.frame,
      collectionViewLayout: materialsCollectionViewFlowLayout
    )
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    collectionView.register(
      MaterialsInIceBoxCollectionViewCell.self,
      forCellWithReuseIdentifier: MaterialsInIceBoxCollectionViewCell.identifier
    )
    collectionView.register(
      CategoryCollectionHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: CategoryCollectionHeaderView.identifier)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.backgroundColor = .systemBackground
    
    return collectionView
  }()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
    addAllView()
    setupAddNewMaterialButtonAutoLayout()
    setupMaterielsCollectionViewAutoLayout()
    setMaterialsInIceboxCollectionFlowLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life Cycle
  
  // MARK: - Configuration
  
  private func configureView() {
    self.backgroundColor = .systemBackground
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    self.addSubview(addNewMaterialButton)
    self.addSubview(backButon)
    self.addSubview(emptyImageView)
    self.addSubview(materialsCollectionView)
    
    self.bringSubviewToFront(emptyImageView)
  }
  
  private func setupAddNewMaterialButtonAutoLayout() {
    let safeArea = self.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
      addNewMaterialButton.topAnchor     .constraint(equalTo: safeArea.topAnchor),
      addNewMaterialButton.trailingAnchor .constraint(equalTo: safeArea.trailingAnchor, constant: -10),
    ])
    
    NSLayoutConstraint.activate([
      backButon.topAnchor     .constraint(equalTo: safeArea.topAnchor, constant: 4),
      backButon.leadingAnchor .constraint(equalTo: safeArea.leadingAnchor, constant: 10),
    ])
    
    NSLayoutConstraint.activate([
      emptyImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 176),
      emptyImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      emptyImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      emptyImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -176)
    ])
  }
  
  private func setupMaterielsCollectionViewAutoLayout() {
    let safeArea = self.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
      materialsCollectionView.topAnchor     .constraint(equalTo: addNewMaterialButton.bottomAnchor, constant: 10),
      materialsCollectionView.leadingAnchor .constraint(equalTo: safeArea.leadingAnchor),
      materialsCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      materialsCollectionView.bottomAnchor  .constraint(equalTo: safeArea.bottomAnchor),
    ])
  }
  
  // MARK: - Element Control
  
  func setMaterialsInIceboxCollectionFlowLayout() {
    let itemsInLine: CGFloat = 3
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
    
    materialsCollectionViewFlowLayout.minimumLineSpacing = singleItemSpacing
    materialsCollectionViewFlowLayout.minimumInteritemSpacing = singleItemSpacing
    materialsCollectionViewFlowLayout.sectionInset = edgeInsets
    
    materialsCollectionViewFlowLayout.itemSize = itemSize
  }
  
  func emptyImageView(isHidden: Bool) {
    emptyImageView.isHidden = isHidden
  }
  
  func reloadMaterialsCollectionViewData() {
    materialsCollectionView.reloadData()
  }
  
  // MARK: - Action Handler
  
  @objc
  private func whenDidAddNewMaterialButtonTouchUpInside(_ sender: UIButton) {
    delegate?.whenDidAddNewMaterialButtonTouchUpInside(sender)
  }
  
  @objc
  private func whenDidBackButonTouchUpInside(_ sender: UIButton) {
    delegate?.whenDidBackButonTouchUpInside(sender)
  }
}

extension MaterialsInIceboxView: UICollectionViewDataSource {  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    delegate?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    delegate?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
  }
}

extension MaterialsInIceboxView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
  }
}
