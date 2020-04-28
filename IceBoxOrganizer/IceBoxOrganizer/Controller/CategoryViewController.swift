//
//  CategoryViewController.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
  
  // MARK: - Properties
  
  private let categoryView = CategoryView()
  
  var viewFor: ShownType!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    setupViewAutoLayout()
  }
  
  // MARK: - Configuration
  
  private func configureViewController() {
    categoryView.delegate = self
  }
  
  // MARK: - Setup UI
  
  private func setupViewAutoLayout() {
    view.addSubview(categoryView)
    
    categoryView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      categoryView.topAnchor     .constraint(equalTo: view.topAnchor),
      categoryView.leadingAnchor .constraint(equalTo: view.leadingAnchor),
      categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      categoryView.bottomAnchor  .constraint(equalTo: view.bottomAnchor),
    ])
  }
  
}

extension CategoryViewController: CategoryViewDelegate {
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: CategoryCollectionHeaderView.identifier,
      for: indexPath
      ) as! CategoryCollectionHeaderView
    
    let title = Category.allCases[indexPath.section].rawValue
    let image = UIImage(named: Category.allCases[indexPath.section].rawValue) ?? UIImage()
    
    header.setCategoryTitleLabel(title: title)
    header.setCategoryImageView(image: image)
    
    return header
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Category.allValues.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    Category.allValues[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MaterialsInIceBoxCollectionViewCell.identifier,
      for: indexPath
      ) as! MaterialsInIceBoxCollectionViewCell
    
    var category = ""
    
    switch indexPath.section {
    case 0: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.Condiment).rawValue
    case 1: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.GrainAndNuts).rawValue
    case 2: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.Meat).rawValue
    case 3: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.ProcessedFoodAndDairy).rawValue
    case 4: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.Seafood).rawValue
    case 5: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.VegetableAndFruit).rawValue
    default: break
    }
    
    cell.set(image: UIImage(named: category) ?? UIImage(), text: category)
    
    return cell
  }
  
}

extension CategoryViewController {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    var category = ""
    
    switch indexPath.section {
    case 0: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.Condiment).rawValue
    case 1: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.GrainAndNuts).rawValue
    case 2: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.Meat).rawValue
    case 3: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.ProcessedFoodAndDairy).rawValue
    case 4: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.Seafood).rawValue
    case 5: category = (Category.allValues[indexPath.section][indexPath.item] as! Category.VegetableAndFruit).rawValue
    default: break
    }
    
    var detailMaterialViewController: DetailMaterialViewController!
    
    switch viewFor {
    case .creat:
      detailMaterialViewController = presentingViewController as? DetailMaterialViewController
    case .edit:
      guard let navigationController = presentingViewController as? UINavigationController else { return }
      detailMaterialViewController = navigationController.viewControllers.last as? DetailMaterialViewController
    case .none: break
    }
    
    detailMaterialViewController.setCategoryButton(text: category)
    
    dismiss(animated: true)
  }
}
