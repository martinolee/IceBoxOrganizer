//
//  CategoryViewDelegate.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

protocol CategoryViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}
