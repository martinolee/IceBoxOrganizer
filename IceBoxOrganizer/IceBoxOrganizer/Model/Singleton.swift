//
//  Singleton.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import CoreData

class Singleton {
  static let shared = Singleton()
  
  private init() { }
  
  var materialsInIcebox = [MaterialEntity]()
  
  var context: NSManagedObjectContext {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
    
    return appDelegate.persistentContainer.viewContext
  }
}
