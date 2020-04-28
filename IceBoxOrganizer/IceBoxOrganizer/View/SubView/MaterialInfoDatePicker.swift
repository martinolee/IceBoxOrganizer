//
//  MaterialInfoDatePicker.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class MaterialInfoDatePicker: UIDatePicker {
  
  enum `Type` {
    case expirationDate, buyingDate
  }
  
  var type: Type!
  
}
