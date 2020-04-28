//
//  IceBoxView.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/01/31.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class IceboxView: UIView {
  
  // MARK: -Strunc
  
  struct IceboxSize {
    static let width: CGFloat = 106
    static let height: CGFloat = 220
  }
  
  // MARK: - Properties
  
  var delegate: IceboxViewDelegate?
  
  private let seeAllMaterialsButton: UIButton = {
    let button = UIButton(type: .system)
    let allImage = UIImage(systemName: "circle.grid.3x3.fill")

    button.translatesAutoresizingMaskIntoConstraints = false

    button.setPreferredSymbolConfiguration(.init(pointSize: 30), forImageIn: .normal)
    button.setImage(allImage, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    
    button.tintColor = ColorZip.ivory
    
    button.addTarget(self, action: #selector(whenDidTapSeeAllMaterialButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  private let freezerButton: IceboxButton = {
    let button = IceboxButton(type: .system)
    let freezeImage = UIImage(named: "Freeze")
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.setBackgroundImage(freezeImage, for: .normal)
    button.iceboxType = .freezer
    button.contentMode = .scaleAspectFit
    button.imageView?.contentMode = .scaleAspectFit
    
    button.addTarget(self, action: #selector(whenDidTouchedUpInsideIceboxButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  private let refrigeratorButton: IceboxButton = {
    let button = IceboxButton(type: .system)
    let refrigerationImage = UIImage(named: "Refrigeration")
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.setBackgroundImage(refrigerationImage, for: .normal)
    button.iceboxType = .refrigerator
    button.contentMode = .scaleAspectFit
    button.imageView?.contentMode = .scaleAspectFit
    
    button.addTarget(self, action: #selector(whenDidTouchedUpInsideIceboxButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
    addAllViews()
    setupSeeAllMaterialsButtonAutoLayout()
    setupFreezerButtonAutoLayout()
    setupRefrigeratorButtonAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  
  private func configureView() {
    self.backgroundColor = .systemBackground
  }
  
  // MARK: - Setup UI
  
  private func addAllViews() {
    self.addSubview(seeAllMaterialsButton)
    self.addSubview(freezerButton)
    self.addSubview(refrigeratorButton)
  }
  
  private func setupSeeAllMaterialsButtonAutoLayout() {
    let safeArea = self.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      seeAllMaterialsButton.topAnchor     .constraint(equalTo: safeArea.topAnchor),
      seeAllMaterialsButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
      seeAllMaterialsButton.widthAnchor   .constraint(equalToConstant: 30),
      seeAllMaterialsButton.heightAnchor  .constraint(equalToConstant: 30),
    ])
  }
  
  private func setupFreezerButtonAutoLayout() {
    NSLayoutConstraint.activate([
      freezerButton.centerYAnchor .constraint(equalTo: self.centerYAnchor,  constant: -130),
      freezerButton.centerXAnchor .constraint(equalTo: self.centerXAnchor),
      freezerButton.widthAnchor   .constraint(equalToConstant: 340 / 1.5),
      freezerButton.heightAnchor  .constraint(equalToConstant: 190 / 1.5),
    ])
  }
  
  private func setupRefrigeratorButtonAutoLayout() {
    NSLayoutConstraint.activate([
      refrigeratorButton.topAnchor     .constraint(equalTo: freezerButton.bottomAnchor),
      refrigeratorButton.centerXAnchor .constraint(equalTo: freezerButton.centerXAnchor),
      refrigeratorButton.widthAnchor.constraint(equalToConstant: 342 / 1.5),
      refrigeratorButton.heightAnchor.constraint(equalToConstant: 332 / 1.5),
    ])
  }
  
  // MARK: - Element Control
  
  @objc
  private func whenDidTapSeeAllMaterialButton(_ button: UIButton) {
    delegate?.whenDidTapSeeAllMaterialButton(button)
  }
  
  @objc
  private func whenDidTouchedUpInsideIceboxButton(_ button: IceboxButton) {
    delegate?.whenDidTouchedUpInsideIceboxButton(button, icebox: button.iceboxType)
  }
  
}
