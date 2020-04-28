//
//  UIViewExtension.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/07.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

extension UIView {
  func bindToKeyboard(){
    NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  @objc
  func keyboardWillChange(_ notification: NSNotification) {
    let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
    let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let deltaY = targetFrame.origin.y - curFrame.origin.y
    UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
      self.frame.origin.y += deltaY
    },completion: {(true) in
      self.layoutIfNeeded()
    })
  }
}

