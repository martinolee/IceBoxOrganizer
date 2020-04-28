//
//  LaunchScreenViewController.swift
//  IceBoxOrganizer
//
//  Created by 은영김 on 2020/02/07.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

  // MARK: -Strunc
  
  struct itemSize {
    static let iceboxWSize: CGFloat = 240
    static let iceboxHSize: CGFloat = 160
    static let iceboxTitleWSize: CGFloat = 414
    static let iceboxTitleHSize: CGFloat = 224
  }
  
  // MARK: - Properties
  
  private let iceboxImageView: UIImageView = {
    let iceboxImageView = UIImageView()
    iceboxImageView.image = UIImage(named: "icebox")
    return iceboxImageView
  }()
  
  private let iceboxTitleImageView: UIImageView = {
    let iceboxTitleImageView = UIImageView()
    iceboxTitleImageView.image = UIImage(named: "iceboxTitle")
    return iceboxTitleImageView
  }()
  
  
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = ColorZip.midiumGray
      navigationController?.navigationBar.isHidden = true
      setupViewAutoLayout()
      
    }
    

  // MARK: - Setup UI
  
  private func setupViewAutoLayout() {
    [iceboxImageView, iceboxTitleImageView].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.contentMode = .scaleAspectFit
    }
    
    NSLayoutConstraint.activate([
      iceboxTitleImageView.widthAnchor   .constraint(equalToConstant: itemSize.iceboxTitleWSize),
      iceboxTitleImageView.heightAnchor  .constraint(equalToConstant: itemSize.iceboxTitleHSize),
      iceboxTitleImageView.centerYAnchor .constraint(equalTo: view.centerYAnchor, constant: 30),
      iceboxTitleImageView.centerXAnchor .constraint(equalTo: view.centerXAnchor),
    ])
    
    NSLayoutConstraint.activate([
      iceboxImageView.widthAnchor        .constraint(equalToConstant: itemSize.iceboxWSize),
      iceboxImageView.heightAnchor       .constraint(equalToConstant: itemSize.iceboxHSize),
      iceboxImageView.bottomAnchor       .constraint(equalTo: iceboxTitleImageView.topAnchor, constant: 60),
      iceboxImageView.centerXAnchor      .constraint(equalTo: view.centerXAnchor),

    ])
  }

}
