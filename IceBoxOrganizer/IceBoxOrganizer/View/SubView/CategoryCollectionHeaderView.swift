//
//  CategoryCollectionHeaderView.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/06.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class CategoryCollectionHeaderView: UICollectionReusableView {
  
  // MARK: - Properites
  
  static let identifier = "CategoryCollectionHeaderView"
  
  private let blurView: UIVisualEffectView = {
    let blurView = UIVisualEffectView()
    
    blurView.translatesAutoresizingMaskIntoConstraints = false
    
    let blurEffect = UIBlurEffect(style: .extraLight)
    blurView.effect = blurEffect
    
    return blurView
  }()
  
  private let categoryTitleLabel: UILabel = {
    let label = UILabel()
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.textColor = .black
    label.font = .systemFont(ofSize: 16)
    
    return label
  }()
  
  private let categoryImageView: UIImageView = {
    let imageView = UIImageView()
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addAllView()
    setupBlurViewAutoLayout()
    setupCategoryImgaeViewAutoLayout()
    setupCategoryTitleLabelAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    self.addSubview(blurView)
    blurView.contentView.addSubview(categoryImageView)
    blurView.contentView.addSubview(categoryTitleLabel)
  }
  
  private func setupBlurViewAutoLayout() {
    NSLayoutConstraint.activate([
      blurView.topAnchor     .constraint(equalTo: self.topAnchor),
      blurView.leadingAnchor .constraint(equalTo: self.leadingAnchor),
      blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      blurView.bottomAnchor  .constraint(equalTo: self.bottomAnchor),
    ])
  }
  
  private func setupCategoryImgaeViewAutoLayout() {
    NSLayoutConstraint.activate([
//      categoryImageView.topAnchor     .constraint(equalTo: blurView.topAnchor),
//      categoryImageView.leadingAnchor .constraint(equalTo: blurView.leadingAnchor, constant: 6),
//      categoryImageView.trailingAnchor.constraint(equalTo: categoryTitleLabel.leadingAnchor, constant: 6),
//      categoryImageView.bottomAnchor  .constraint(equalTo: blurView.bottomAnchor),
      categoryImageView.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
      categoryImageView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 20),
      categoryImageView.heightAnchor.constraint(equalTo: blurView.heightAnchor, multiplier: 0.75),
      categoryImageView.widthAnchor.constraint(equalTo: categoryImageView.heightAnchor),
    ])
    
    
  }
  
  private func setupCategoryTitleLabelAutoLayout() {
    NSLayoutConstraint.activate([
//      categoryTitleLabel.centerYAnchor .constraint(equalTo: blurView.centerYAnchor),
      categoryTitleLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
      categoryTitleLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 20),
      categoryTitleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
    ])
  }
  
  // MARK: - Configure
  
  // MARK: - Element Control
  
  func setCategoryTitleLabel(title: String) { categoryTitleLabel.text = title }
  
  func setCategoryImageView(image: UIImage) { categoryImageView.image = image }

}
