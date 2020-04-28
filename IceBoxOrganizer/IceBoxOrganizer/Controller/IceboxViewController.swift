//
//  IceBoxViewController.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/01/31.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class IceboxViewController: UIViewController {
  
  // MARK: - Properties
  
  private let iceBoxView = IceboxView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    setupIceBoxView()
  }
  
  // MARK: - Configuration
  
  private func configureViewController() {
    iceBoxView.delegate = self
    
    navigationController?.navigationBar.isHidden = true
  }
  
  // MARK: - Setup UI
  
  private func setupIceBoxView() {
    view.addSubview(iceBoxView)
    
    iceBoxView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      iceBoxView.topAnchor     .constraint(equalTo: view.topAnchor),
      iceBoxView.leadingAnchor .constraint(equalTo: view.leadingAnchor),
      iceBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      iceBoxView.bottomAnchor  .constraint(equalTo: view.bottomAnchor),
    ])
  }
  
}

extension IceboxViewController: IceboxViewDelegate {
  func whenDidTapSeeAllMaterialButton(_ button: UIButton) {
    let materialsInIceboxViewController = MaterialsInIceboxViewController()
    
    materialsInIceboxViewController.inIcebox = .all
    
    navigationController?.pushViewController(materialsInIceboxViewController, animated: true)
  }
  
  func whenDidTouchedUpInsideIceboxButton(_ button: IceboxButton, icebox: Icebox) {
    let materialsInIceboxViewController = MaterialsInIceboxViewController()
    
    materialsInIceboxViewController.inIcebox = icebox
    
    navigationController?.pushViewController(materialsInIceboxViewController, animated: true)
  }
}
