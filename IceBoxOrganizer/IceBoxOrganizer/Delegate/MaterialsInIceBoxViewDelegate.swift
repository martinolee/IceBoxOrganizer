//
//  MaterialsInIceBoxViewDelegate.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

protocol MaterialsInIceBoxViewDelegate {
  func whenDidAddNewMaterialButtonTouchUpInside(_ button: UIButton)
  
  func whenDidBackButonTouchUpInside(_ button: UIButton)
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}
