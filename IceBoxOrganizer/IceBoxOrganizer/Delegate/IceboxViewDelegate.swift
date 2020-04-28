//
//  IceBoxViewDelegate.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/01/31.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

protocol IceboxViewDelegate {
  
  func whenDidTapSeeAllMaterialButton(_ button: UIButton)
  
  func whenDidTouchedUpInsideIceboxButton(_ button: IceboxButton, icebox: Icebox)
}
