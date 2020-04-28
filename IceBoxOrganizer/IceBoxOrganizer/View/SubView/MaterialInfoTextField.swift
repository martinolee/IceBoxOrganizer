//
//  MaterialInfoTextField.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class MaterialInfoTextField: UITextField {
  
  enum `Type` {
    case name, price, expirationDate, buyingDate, buyingLocation
  }
  
  var type: Type!
  
}
