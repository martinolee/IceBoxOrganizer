//
//  MaterialsInIceboxViewController.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import CoreData

class MaterialsInIceboxViewController: UIViewController {
  
  // MARK: - Properites
  
  private var materialsInIceboxView = MaterialsInIceboxView()
  
  var inIcebox: Icebox!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    setupMaterialsInIceboxView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    fetchMaterials()
  }
  
  // MARK: - Configuration
  
  private func configureViewController() {
    navigationController?.navigationBar.isHidden = true
  }
  
  // MARK: - Setup UI
  
  private func setupMaterialsInIceboxView() {
    view.addSubview(materialsInIceboxView)
    
    materialsInIceboxView.delegate = self
    materialsInIceboxView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      materialsInIceboxView.topAnchor     .constraint(equalTo: view.topAnchor),
      materialsInIceboxView.leadingAnchor .constraint(equalTo: view.leadingAnchor),
      materialsInIceboxView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      materialsInIceboxView.bottomAnchor  .constraint(equalTo: view.bottomAnchor),
    ])
  }
  
  // MARK: -
  
  func fetchMaterials() {
    let request = NSFetchRequest<MaterialEntity>(entityName: "Material")
    
    let sortByInsertDate = NSSortDescriptor(key: "insertDate", ascending: false)
    let sortByCategory = NSSortDescriptor(key: "category", ascending: true)
    
    request.sortDescriptors = [sortByInsertDate, sortByCategory]
    Singleton.shared.materialsInIcebox.removeAll()
    
    do {
      let materials = try Singleton.shared.context.fetch(request)
      
      Singleton.shared.materialsInIcebox = materials
    } catch {
      print(error.localizedDescription)
    }
    
    materialsInIceboxView.reloadMaterialsCollectionViewData()
  }
  
}

extension MaterialsInIceboxViewController: MaterialsInIceBoxViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    var itemCount: Int!
    
    switch inIcebox {
    case .freezer:
      itemCount = Singleton.shared.materialsInIcebox
        .filter { $0.storingType == Int16(Icebox.freezer.key) }
        .count
    case .refrigerator:
      itemCount = Singleton.shared.materialsInIcebox
        .filter { $0.storingType == Int16(Icebox.refrigerator.key) }
        .count
    case .all:
      itemCount = Singleton.shared.materialsInIcebox.count
    case .none:
      break
    }
    
    itemCount == 0 ? materialsInIceboxView.emptyImageView(isHidden: false) : materialsInIceboxView.emptyImageView(isHidden: true)
    
    return itemCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MaterialsInIceBoxCollectionViewCell.identifier,
      for: indexPath
      ) as! MaterialsInIceBoxCollectionViewCell
    
    var material: MaterialEntity!
    
    switch inIcebox {
    case .freezer:
      material = Singleton.shared.materialsInIcebox
        .filter { $0.storingType == Int16(Icebox.freezer.key) }[indexPath.item]
    case .refrigerator:
      material = Singleton.shared.materialsInIcebox
        .filter { $0.storingType == Int16(Icebox.refrigerator.key) }[indexPath.item]
    case .all:
      material = Singleton.shared.materialsInIcebox[indexPath.item]
    case .none: break
    }
    
    if let category = material.category, let materialImage = UIImage(named: category), let materialName = material.name {
      cell.set(image: materialImage, text: materialName)
    }
    
    return cell
  }
  
}

extension MaterialsInIceboxViewController {
  func whenDidAddNewMaterialButtonTouchUpInside(_ button: UIButton) {
    let detailMaterialViewController = DetailMaterialViewController()
    
    detailMaterialViewController.viewFor = .creat
    detailMaterialViewController.from = inIcebox
    
    present(detailMaterialViewController, animated: true)
  }
  
  func whenDidBackButonTouchUpInside(_ button: UIButton) {
    navigationController?.popViewController(animated: true)
  }
}

extension MaterialsInIceboxViewController {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailMaterialViewController = DetailMaterialViewController()
    
    detailMaterialViewController.viewFor = .edit
    detailMaterialViewController.from = inIcebox
    
    switch inIcebox {
    case .freezer:
      detailMaterialViewController.material = Singleton.shared.materialsInIcebox
        .filter { $0.storingType == Int16(Icebox.freezer.key) }[indexPath.item]
    case .refrigerator:
      detailMaterialViewController.material = Singleton.shared.materialsInIcebox
        .filter { $0.storingType == Int16(Icebox.refrigerator.key) }[indexPath.item]
    case .all:
      detailMaterialViewController.material = Singleton.shared.materialsInIcebox[indexPath.item]
    case .none: break
    }
    
    navigationController?.pushViewController(detailMaterialViewController, animated: true)
  }
}
