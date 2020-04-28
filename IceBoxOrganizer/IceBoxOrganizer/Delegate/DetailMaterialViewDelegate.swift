//
//  DetailMaterialViewDelegate.swift
//  IceBoxOrganizer
//
//  Created by Soohan Lee on 2020/02/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

protocol DetailMaterialViewDelegate {
  func whenEditingDidBeginBuyingDateTextField(_ textField: UITextField)
  
  func whenEditingDidBeginExpirationDateTextField(_ textField: UITextField)
  
  func whenDidTouchUpInsideCategoryButton(_ button: UIButton)
  
  func whenDidTouchUpInsideInsertMaterialButton(_ button: UIButton)
  
  func whenValueDidChangededDatePicker(_ datePicker: MaterialInfoDatePicker, type: MaterialInfoDatePicker.`Type`)
  
  func whenDidTouchUpInsideRemoveButton(_ button: UIButton)
  
  func whenDidTouchUpInsideSaveButton(_ button: UIButton)
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
}
