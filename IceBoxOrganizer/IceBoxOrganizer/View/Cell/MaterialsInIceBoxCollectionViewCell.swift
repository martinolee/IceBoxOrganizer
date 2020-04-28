//
//  MeterialsInIceBoxCollectionViewCell.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class MaterialsInIceBoxCollectionViewCell: UICollectionViewCell {
  
  // MARK: Properties
  
  static let identifier = "MeterialsInIceBoxCollectionViewCell"
  
  private let materialImageView: UIImageView = {
    let imageView = UIImageView()
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    let radius: CGFloat = 8
    
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = radius
    
    imageView.layer.shadowOpacity = 0.5
    imageView.layer.shadowColor = UIColor.gray.cgColor
    imageView.layer.shadowRadius = radius
    imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
    
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private let materialLabel: UILabel = {
    let label = UILabel()
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Label"
    label.textAlignment = .center
    
    return label
  }()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addAllViews()
    setupMaterialImageView()
    setupMaterialLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func addAllViews() {
    self.addSubview(materialImageView)
    self.addSubview(materialLabel)
  }
  
  private func setupMaterialImageView() {
    NSLayoutConstraint.activate([
      materialImageView.topAnchor     .constraint(equalTo: self.topAnchor),
      materialImageView.leadingAnchor .constraint(equalTo: self.leadingAnchor),
      materialImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      materialImageView.widthAnchor   .constraint(equalTo: self.widthAnchor),
      materialImageView.heightAnchor  .constraint(equalTo: materialImageView.widthAnchor),
    ])
  }
  
  private func setupMaterialLabel() {
    NSLayoutConstraint.activate([
      materialLabel.topAnchor     .constraint(equalTo: materialImageView.bottomAnchor),
      materialLabel.leadingAnchor .constraint(equalTo: materialImageView.leadingAnchor),
      materialLabel.trailingAnchor.constraint(equalTo: materialImageView.trailingAnchor),
    ])
  }
  
  // MARK: - Element Control
  
  func set(image: UIImage, text: String) {
    materialImageView.image = image
    materialLabel.text = text
  }
  
}
