//
//  IceBox.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/01/31.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

enum Icebox: Int16 {
  case freezer
  case refrigerator
  case all
  
  var key: Int16 {
    switch self {
    case .freezer: return 0
    case .refrigerator: return 1
    case .all: return 2
    }
  }
  
  static let allValues = [freezer, refrigerator]
}

enum ShownType {
  case edit, creat
}
