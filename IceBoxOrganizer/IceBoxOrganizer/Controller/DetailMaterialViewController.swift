//
//  DetailMaterialViewController.swift
//  IceBoxOrganizer
//
//  Created by 은영김 on 2020/02/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices

class DetailMaterialViewController: UIViewController {
  
  // MARK: - Properites
  
  private let detailMaterialView = DetailMaterialView()
  
  var viewFor: ShownType!
  var from: Icebox!
  var material: MaterialEntity?
  let locationData = ["마트", "편의점", "시장", "백화점", "기타"]
  
  private lazy var imagePickerController: UIImagePickerController = {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    return picker
  }()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    setupView()
    setupDynamicAutoLayout()
    setupInitStoringType()
    loadMaterialData()
  }
  
  // MARK: - Configuration
  
  private func configureViewController() {
    view.backgroundColor = .white
    navigationController?.navigationBar.isHidden = true
    detailMaterialView.delegate = self
  }
  
  private func loadMaterialData() {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    
    guard
      let editMaterial = material,
      let name = editMaterial.name,
      let category = editMaterial.category,
      let expirationDate = editMaterial.expirationDate,
      let buyingDate = editMaterial.buyingDate,
      let buyingLocation = editMaterial.buyingLocation
      else { return }
    
    let storingType = Int(editMaterial.storingType)
    let strPrice = String(editMaterial.price)
    let strExpirationDate = dateFormatter.string(from: expirationDate)
    let strBuyingDate = dateFormatter.string(from: buyingDate)
    let materialImage = UIImage(data: material?.image ?? Data())
    
    detailMaterialView.setStoringTypeSegmentedControl(index: storingType)
    detailMaterialView.setNameTextField(text: name)
    detailMaterialView.setCategoryButton(text: category)
    detailMaterialView.setPriceTextField(text: strPrice)
    detailMaterialView.setExpirationTextField(text: strExpirationDate)
    detailMaterialView.setBuyingDateTextField(text: strBuyingDate)
    detailMaterialView.setBuyingLocationTextField(text: buyingLocation)
    
    if materialImage != nil {
      detailMaterialView.setInsertMaterialImageButton(image: materialImage!)
      detailMaterialView.setInsertMaterialImage(backgroundColor: .clear)
    }
  }
  
  private func setupInitStoringType() {
    switch from {
    case .freezer:
      detailMaterialView.setStoringTypeSegmentedControl(index: 0)
    case .refrigerator:
      detailMaterialView.setStoringTypeSegmentedControl(index: 1)
    case .all: break
    case .none: break
    }
  }
  
  private func setupDynamicAutoLayout() {
    NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillShowNotification,
      object: nil,
      queue: OperationQueue.main
    ) { (noti) in
      if let frameValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardFrame = frameValue.cgRectValue
        
        self.detailMaterialView.setInfoViewBottomConstraint(keyboardFrame.height + 20)
        
        UIView.animate(withDuration: 0.3) { self.detailMaterialView.layoutIfNeeded() }
      }
    }
    
    NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillHideNotification,
      object: nil,
      queue: OperationQueue.main
    ) { (noti) in
      self.detailMaterialView.setInfoViewBottomConstraint(0)
      
      UIView.animate(withDuration: 0.3) { self.detailMaterialView.layoutIfNeeded() }
    }
  }
  
  // MARK: - Setup UI
  
  private func setupView() {
    if viewFor == .creat {
      detailMaterialView.setTitleViewHeightConstraint(50)
    }
    
    view.addSubview(detailMaterialView)
    
    detailMaterialView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      detailMaterialView.topAnchor     .constraint(equalTo: view.topAnchor),
      detailMaterialView.leadingAnchor .constraint(equalTo: view.leadingAnchor),
      detailMaterialView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      detailMaterialView.bottomAnchor  .constraint(equalTo: view.bottomAnchor),
    ])
  }
  
  func setCategoryButton(text: String) {
    detailMaterialView.setCategoryButton(text: text)
  }
  
}

extension DetailMaterialViewController: DetailMaterialViewDelegate {
  
  func whenEditingDidBeginBuyingDateTextField(_ textField: UITextField) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    
    textField.text = dateFormatter.string(from: Date())
  }
  
  func whenEditingDidBeginExpirationDateTextField(_ textField: UITextField) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    
    textField.text = dateFormatter.string(from: Date())
  }
  
  func whenDidTouchUpInsideCategoryButton(_ button: UIButton) {
    let categoryViewController = CategoryViewController()
    
    if viewFor == .edit {
      categoryViewController.viewFor = .edit
    } else {
      categoryViewController.viewFor = .creat
    }
    
    present(categoryViewController, animated: true)
  }
  
  
  func whenValueDidChangededDatePicker(_ datePicker: MaterialInfoDatePicker, type: MaterialInfoDatePicker.`Type`) {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    
    let selectedDate: String = dateFormatter.string(from: datePicker.date)
    
    switch type {
    case .expirationDate:
      detailMaterialView.setExpirationTextfield(text: selectedDate)
    case .buyingDate:
      detailMaterialView.setBuyingDateTextField(text: selectedDate)
    }
  }
  
  func whenDidTouchUpInsideInsertMaterialButton(_ button: UIButton) {
    let imagePickerStyleAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    imagePickerStyleAlert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { _ in
      guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
      
      self.imagePickerController.sourceType = .camera
      
      self.imagePickerController.mediaTypes = [kUTTypeImage as String]
      
      self.present(self.imagePickerController, animated: true)
    }))
    imagePickerStyleAlert.addAction(UIAlertAction(title: "사진첩", style: .default, handler: { _ in
      self.imagePickerController.sourceType = .savedPhotosAlbum
      
      self.present(self.imagePickerController, animated: true)
    }))
    imagePickerStyleAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
    
    present(imagePickerStyleAlert, animated: true)
  }
  
  func whenDidTouchUpInsideRemoveButton(_ button: UIButton) {
    
    switch viewFor {
    case .creat:
      let cancelAlert = UIAlertController(title: "등록 취소", message: "재료 등록을 취소하시겠습니까?", preferredStyle: .alert)
      
      cancelAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
      cancelAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
        self.dismiss(animated: true)
      }))
      
      present(cancelAlert, animated: true)
    case .edit:
      guard let materialName = material?.name else { return }
      let removeAlert = UIAlertController(title: "재료 삭제", message: "\(materialName)을(를) 삭제하시겠습니까?", preferredStyle: .alert)
      
      removeAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
      removeAlert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
        if let material = self.material {
          Singleton.shared.context.delete(material)
          
          do {
            try Singleton.shared.context.save()
          } catch {
            print(error.localizedDescription)
          }
        }
        
        self.navigationController?.popViewController(animated: true)
      }))
      
      present(removeAlert, animated: true)
    case .none: break
    }
  }
  
  func whenDidTouchUpInsideSaveButton(_ button: UIButton) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    
    guard
      let storingType = detailMaterialView.getRawStoringType(),
      let name = detailMaterialView.getNameTextFieldText(),
      let category = detailMaterialView.getCategoryButtonText(),
      let strPrice = detailMaterialView.getPriceTextFieldText(),
      let price = Int64(strPrice),
      let strExpirationDate = detailMaterialView.getExpirationTextFieldText(),
      let expirationDate = dateFormatter.date(from: strExpirationDate),
      let strBuyingDate = detailMaterialView.getBuyingDateTextFieldText(),
      let buyingDate = dateFormatter.date(from: strBuyingDate),
      let buyingLocation = detailMaterialView.getBuyingLocationTextField()
      else {
        let missingInfoAlert = UIAlertController(title: "정보 부족", message: "모든 정보가 입력되지 않았습니다.", preferredStyle: .alert)
        
        missingInfoAlert.addAction(UIAlertAction(title: "확인", style: .default))
        
        present(missingInfoAlert, animated: true)
        return
    }
    
    if let editMaterial = material {
      editMaterial.storingType = storingType
      editMaterial.name = name
      editMaterial.category = category
      editMaterial.price = price
      editMaterial.expirationDate = expirationDate
      editMaterial.buyingDate = buyingDate
      editMaterial.buyingLocation = buyingLocation
      let materialImage = detailMaterialView.getMaterialImage()?.pngData()
      editMaterial.image = materialImage
    } else {
      if let newMaterial = NSEntityDescription.insertNewObject(forEntityName: "Material", into: Singleton.shared.context) as? MaterialEntity {
        newMaterial.storingType = storingType
        newMaterial.name = name
        newMaterial.category = category
        newMaterial.price = price
        newMaterial.expirationDate = expirationDate
        newMaterial.buyingDate = buyingDate
        newMaterial.buyingLocation = buyingLocation
        let materialImage = detailMaterialView.getMaterialImage()?.pngData()
        newMaterial.image = materialImage
        newMaterial.insertDate = Date()
      }
    }
    
    do {
      try Singleton.shared.context.save()
    } catch {
      print(error.localizedDescription)
    }
    
    if viewFor == .edit {
      guard
        let navigationController = self.navigationController,
        navigationController.viewControllers.count >= 2 else { return }
      let materialsInIceboxViewController = navigationController.viewControllers[navigationController.viewControllers.count - 2] as! MaterialsInIceboxViewController
      
      materialsInIceboxViewController.fetchMaterials()
      
      navigationController.popViewController(animated: true)
    } else if viewFor == .creat {
      guard let navigationController = presentingViewController as? UINavigationController else { return }
      let materialsInIceboxViewController = navigationController.viewControllers.last as! MaterialsInIceboxViewController
      
      materialsInIceboxViewController.fetchMaterials()
      dismiss(animated: true)
    }
    
  }
}

// MARK: UIPicker

extension DetailMaterialViewController {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    locationData.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    locationData[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    detailMaterialView.setBuyingLocationTextField(text: locationData[row])
  }
}

extension DetailMaterialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let mediaType = info[.mediaType] as! NSString
    
    if UTTypeEqual(mediaType, kUTTypeImage) {
      let originalImage = info[.originalImage] as! UIImage
      let editedImage = info[.editedImage] as? UIImage
      let selectedImage = editedImage ?? originalImage
      
      if picker.sourceType == .camera {
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
      }
      
      imagePickerController.dismiss(animated: true) {
        self.detailMaterialView.setInsertMaterialImageButton(image: selectedImage)
        self.detailMaterialView.setInsertMaterialImage(backgroundColor: .clear)
      }
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
  }
}
