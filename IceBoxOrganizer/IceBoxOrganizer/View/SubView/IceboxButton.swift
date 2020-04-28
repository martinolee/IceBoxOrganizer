//
//  IceboxButton.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class IceboxButton: UIButton {
  
  // MARK: - Properties
  
  var iceboxType: Icebox!
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configurationForButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  
  private func configurationForButton() {
    self.contentMode = .scaleAspectFit
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
}
