//
//  DetailMaterialView.swift
//  IceBoxOrganizer
//
//  Created by 은영김 on 2020/02/04.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class DetailMaterialView: UIView {
  
  // MARK: -Strunc
  
  struct Padding {
    static let inset: CGFloat = 20
    static let ySpace: CGFloat = 30
    static let fontSize: CGFloat = 16
  }
  
  // MARK: -Properites
  
  var delegate: DetailMaterialViewDelegate?
  
  // MARK: UIView
  
  private let titleView: UIView = {
    let titleView = UIView()
    titleView.backgroundColor = ColorZip.ivory
    return titleView
  }()
  
  private let infoView: UIView = {
    let infoView = UIView()
    
    infoView.translatesAutoresizingMaskIntoConstraints = false
    
    return infoView
  }()
  
  // MARK: UIToolbar
  
  let toolbar = UIToolbar()
  
  // MARK: UILabel
  
  private let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.backgroundColor = ColorZip.ivory
    titleLabel.textColor = ColorZip.basicGreen
    titleLabel.text = "Detail Material Info"
    titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
    return titleLabel
  }()
  
  private let nameLabel: UILabel = {
    let nameLabel = UILabel()
    nameLabel.text = "Name"
    return nameLabel
  }()
  
  private let categoryLabel: UILabel = {
    let categoryLabel = UILabel()
    categoryLabel.text = "Category"
    return categoryLabel
  }()
  
  private let priceLabel: UILabel = {
    let priceLabel = UILabel()
    priceLabel.text = "Price"
    return priceLabel
  }()
  
  private let expirationDateLabel: UILabel = {
    let expirationDateLabel = UILabel()
    expirationDateLabel.text = "Expiration Date"
    return expirationDateLabel
  }()
  
  private let buyingDateLabel: UILabel = {
    let buyingDateLabel = UILabel()
    buyingDateLabel.text = "Buying Date"
    return buyingDateLabel
  }()
  
  private let imageLabel: UILabel = {
    let imageLabel = UILabel()
    imageLabel.text = "Photo"
    return imageLabel
  }()
  
  private let buyingLocationLabel: UILabel = {
    let buyingLocationLabel = UILabel()
    buyingLocationLabel.text = "Where"
    return buyingLocationLabel
  }()
  
  private let storingTypeLabel: UILabel = {
    let storingTypeLabel = UILabel()
    storingTypeLabel.text = "StoringType"
    return storingTypeLabel
  }()
  

  // MARK: UIButton
  
  private let removeButton: UIButton = {
    let button = UIButton(type: .system)
    let trasgCanImage = UIImage(systemName: "trash")
    button.setImage(trasgCanImage, for: .normal)
    button.setPreferredSymbolConfiguration(.init(scale: .default), forImageIn: .normal)
    button.tintColor = .systemPink
    button.addTarget(self, action: #selector(whenDidTouchUpInsideRemoveButton(_:)), for: .touchUpInside)
    return button
  }()
  
  private let saveButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("save", for: .normal)
    button.setTitleColor(ColorZip.peanut, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    button.addTarget(self, action: #selector(whenDidTouchUpInsideSaveButton(_:)), for: .touchUpInside)
    return button
  }()
  
  private let categoryButton: UIButton = {
    let categoryButton = UIButton(type: .system)
    categoryButton.setTitle("Select Category", for: .normal)
    categoryButton.setTitleColor(ColorZip.basicGreen, for: .normal)
    categoryButton.backgroundColor = ColorZip.ivory
    categoryButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
    categoryButton.layer.cornerRadius = 4
    categoryButton.addTarget(self, action: #selector(whenDidTouchUpInsideCategoryButton(_:)), for: .touchUpInside)
    return categoryButton
  }()
  
  // MARK: UITextField
  private let nameTextField: MaterialInfoTextField = {
    let nameTextfield = MaterialInfoTextField()
    
    nameTextfield.type = .name
    
    return nameTextfield
  }()
  
  private let priceTextField: MaterialInfoTextField = {
    let priceTextfield = MaterialInfoTextField()
    
    priceTextfield.type = .price
    
    priceTextfield.keyboardType = .numberPad
    
    return priceTextfield
  }()
  
  private let expirationTextField: MaterialInfoTextField = {
    let expirationTextfield = MaterialInfoTextField()
    
    expirationTextfield.type = .expirationDate
    
    expirationTextfield.addTarget(self, action: #selector(whenEditingDidBeginExpirationDateTextField), for: .editingDidBegin)
    
    return expirationTextfield
  }()
  
  private let buyingDateTextField: MaterialInfoTextField = {
    let buyingDateTextfield = MaterialInfoTextField()
    
    buyingDateTextfield.type = .buyingDate
    
    buyingDateTextfield.addTarget(self, action: #selector(whenEditingDidBeginBuyingDateTextField(_:)), for: .editingDidBegin)
    
    return buyingDateTextfield
  }()
  
  private let buyingLocationTextField: MaterialInfoTextField = {
    let buyingLocationTextfield = MaterialInfoTextField()
    
    buyingLocationTextfield.type = .buyingLocation
    
    return buyingLocationTextfield
  }()
  
  private let insertMaterialImageButton: UIButton = {
    let button = UIButton(type: .custom)
    
    button.addTarget(self, action: #selector(whenDidTouchUpInsideInsertMaterialButton(_:)), for: .touchUpInside)
    
    button.backgroundColor = .gray
    button.setTitle("select photo", for: .normal)
    button.titleLabel?.textAlignment = .center
    button.imageView?.contentMode = .scaleAspectFit
    
    button.widthAnchor.constraint(equalToConstant: 180).isActive = true
    button.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
    return button
  }()
  
  // MARK: UIDatePicker
  private lazy var expirationDatePicker: MaterialInfoDatePicker = {
    let expirationDatePicker = MaterialInfoDatePicker()
    
    expirationDatePicker.type = .expirationDate
    
    expirationDatePicker.addTarget(self, action: #selector(whenValueDidChangededDatePicker(_:)), for: .valueChanged)
    
    return expirationDatePicker
  }()
  
  private let buyingDatePicker: MaterialInfoDatePicker = {
    let buyingDatePicker = MaterialInfoDatePicker()
    
    buyingDatePicker.type = .buyingDate
    
    buyingDatePicker.addTarget(self, action: #selector(whenValueDidChangededDatePicker(_:)), for: .valueChanged)
    
    return buyingDatePicker
  }()
  
  // MARK: Picker
  
  private lazy var buyingLocationPicker: UIPickerView = {
    let picker = UIPickerView()
    
    picker.dataSource = self
    picker.delegate = self
    
    return picker
  }()
  
  // MARK: UISegmentedControl
  private let storingTypeSegment: UISegmentedControl = {
    let stroingTyoe = ["냉동", "냉장"]
    let storingTypeSegment = UISegmentedControl(items: stroingTyoe)
    //    storingTypeSegment.intrinsicContentSize.width = CGSize(width: 180, height: 30)
    storingTypeSegment.widthAnchor.constraint(equalToConstant: 180).isActive = true
    return storingTypeSegment
  }()
  
  // MARK: - Constraint
  
  private lazy var titleViewHeightConstraint = titleView.heightAnchor.constraint(equalToConstant: 100)
  private lazy var infoViewBottomConstraint = infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
  
  //MARK: Properites List
  private lazy var titleList = [titleView, titleLabel, removeButton, saveButton,]
  private lazy var labelList = [storingTypeLabel, nameLabel, categoryLabel, priceLabel, expirationDateLabel, buyingDateLabel, buyingLocationLabel, imageLabel,]
  private lazy var enterList = [storingTypeSegment, nameTextField, categoryButton, priceTextField, expirationTextField, buyingDateTextField, buyingLocationTextField, insertMaterialImageButton]
  
  private lazy var textfieldList = [nameTextField, priceTextField, buyingLocationTextField, expirationTextField,buyingDateTextField]
  private lazy var datePickerList = [expirationDatePicker, buyingDatePicker,]
  private lazy var dateTextFieldList = [expirationTextField, buyingDateTextField,]
  
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
    setupConstraint()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - setup
  
  private func setupConstraint() {
    let safeArea = self.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
      titleView.topAnchor     .constraint(equalTo: self.topAnchor),
      titleView.leadingAnchor .constraint(equalTo: self.leadingAnchor),
      titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      titleViewHeightConstraint,
    ])
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
      titleLabel.topAnchor    .constraint(equalTo: safeArea.topAnchor, constant: 10),
    ])
    
    removeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      removeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      removeButton.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: Padding.inset - 10)
    ])
    
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      saveButton.centerYAnchor .constraint(equalTo: titleLabel.centerYAnchor),
      saveButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -Padding.inset + 10)
    ])
    
    NSLayoutConstraint.activate([
      infoView.topAnchor     .constraint(lessThanOrEqualTo: titleView.bottomAnchor),
      infoView.leadingAnchor .constraint(equalTo: titleView.leadingAnchor),
      infoView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
      infoViewBottomConstraint,
    ])
    
    for (index, value) in labelList.enumerated() {
      value.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Padding.inset).isActive = true
      if index == 0 {
        value.topAnchor.constraint(equalTo: infoView.topAnchor, constant: Padding.ySpace).isActive = true
      } else {
        value.topAnchor.constraint(equalTo: labelList[index - 1].bottomAnchor, constant: Padding.inset + 32).isActive = true
      }
    }
    for (index, value) in enterList.enumerated() {
      value.leadingAnchor.constraint(equalTo: labelList[index].trailingAnchor, constant: Padding.inset - 5).isActive = true
      if index == 0 {
        value.topAnchor.constraint(equalTo: infoView.topAnchor, constant: Padding.ySpace).isActive = true
      } else {
        value.topAnchor.constraint(equalTo: labelList[index - 1].bottomAnchor, constant: Padding.inset + 32).isActive = true
      }
    }
  }
  
  private func setupUI() {
    
    self.addSubview(infoView)

    labelList.forEach {
      $0.textColor = ColorZip.lightRed
      $0.backgroundColor = .white
      $0.font = .systemFont(ofSize: Padding.fontSize, weight: .bold)
      $0.textAlignment = .left
      infoView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    enterList.forEach {
      infoView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    infoView.addSubview(insertMaterialImageButton)
    
    textfieldList.forEach {
      $0.textAlignment = .left
      $0.textColor = ColorZip.midiumGray
      $0.font = .systemFont(ofSize: Padding.fontSize, weight: .light)
      $0.borderStyle = .roundedRect
      $0.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    datePickerList.forEach {
      $0.timeZone = NSTimeZone.local
      $0.backgroundColor = .white
      $0.layer.cornerRadius = 5.0
      $0.layer.shadowOpacity = 0.5
      $0.datePickerMode = .date
    }
    
    dateTextFieldList.forEach {
      $0.text = ""
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: Padding.fontSize, weight: .light)
    }
    
    self.addSubview(titleView)
    titleView.addSubview(removeButton)
    titleView.addSubview(titleLabel)
    titleView.addSubview(saveButton)
    
    titleList.forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    toolbar.sizeToFit()
    expirationTextField.inputAccessoryView = toolbar
    expirationTextField.inputView = expirationDatePicker
    buyingDateTextField.inputAccessoryView = toolbar
    buyingDateTextField.inputView = buyingDatePicker
    
    buyingLocationTextField.inputAccessoryView = toolbar
    buyingLocationTextField.inputView = buyingLocationPicker
    
    self.bringSubviewToFront(titleView)
  }
  
  // MARK: - Action Handler
  
  @objc
  private func whenEditingDidBeginBuyingDateTextField(_ sender: UITextField) {
    delegate?.whenEditingDidBeginBuyingDateTextField(sender)
  }
  
  @objc
  private func whenEditingDidBeginExpirationDateTextField(_ sender: UITextField) {
    delegate?.whenEditingDidBeginExpirationDateTextField(sender)
  }
  
  @objc
  private func whenDidTouchUpInsideCategoryButton(_ sender: UIButton) {
    delegate?.whenDidTouchUpInsideCategoryButton(sender)
  }
  
  @objc
  private func whenValueDidChangededDatePicker(_ sender: MaterialInfoDatePicker) {
    delegate?.whenValueDidChangededDatePicker(sender, type: sender.`type`)
  }
  
  @objc
  private func whenDidTouchUpInsideRemoveButton(_ sender: UIButton) {
    delegate?.whenDidTouchUpInsideRemoveButton(sender)
  }
  
  @objc
  private func whenDidTouchUpInsideSaveButton(_ sender: UIButton) {
    delegate?.whenDidTouchUpInsideSaveButton(sender)
  }
  
  @objc
  private func whenDidTouchUpInsideInsertMaterialButton(_ sender: UIButton) {
    delegate?.whenDidTouchUpInsideInsertMaterialButton(sender)
  }
  
  // MARK: - Element Control
  
  func setTitleViewHeightConstraint(_ consatnt: CGFloat) { titleViewHeightConstraint.constant = consatnt }
  
  func setInfoViewBottomConstraint(_ constant: CGFloat) { infoViewBottomConstraint.constant = constant }
  
  func setCategoryButton(text: String) { categoryButton.setTitle(text, for: .normal) }
  
  func setStoringTypeSegmentedControl(index: Int) { storingTypeSegment.selectedSegmentIndex = index }
  
  func setNameTextField(text: String) { nameTextField.text = text }
  
  func setPriceTextField(text: String) { priceTextField.text = text }
  
  func setExpirationTextfield(text: String) { expirationTextField.text = text }
  
  func setBuyingDateTextField(text: String) { buyingDateTextField.text = text }
  
  func setExpirationTextField(text: String) { expirationTextField.text = text }
  
  func setBuyingLocationTextField(text: String) { buyingLocationTextField.text = text }
  
  func setInsertMaterialImageButton(image: UIImage) { insertMaterialImageButton.setImage(image, for: .normal) }
  
  func setInsertMaterialImage(backgroundColor: UIColor) { insertMaterialImageButton.backgroundColor = backgroundColor }
  
  func getRawStoringType() -> Int16? {
    storingTypeSegment.selectedSegmentIndex == Icebox.freezer.key ? Icebox.freezer.key : Icebox.refrigerator.key
  }
  
  func getNameTextFieldText() -> String? {
    let text = nameTextField.text?.trimmingCharacters(in: .whitespaces)
    
    return text?.count ?? -1 > 0 ? text : nil
  }
  
  func getCategoryButtonText() -> String? {
    let text = categoryButton.titleLabel?.text
    
    return text != "Select Category" ? text : nil
  }
  
  func getPriceTextFieldText() -> String? {
    let text = priceTextField.text?.trimmingCharacters(in: .whitespaces)
    
    return text?.count ?? -1 > 0 ? text : nil
  }
  
  func getExpirationTextFieldText() -> String? {
    let text = expirationTextField.text?.trimmingCharacters(in: .whitespaces)
    
    return text?.count ?? -1 > 0 ? text : nil
  }
  
  func getBuyingDateTextFieldText() -> String? {
    let text = buyingDateTextField.text?.trimmingCharacters(in: .whitespaces)
    
    return text?.count ?? -1 > 0 ? text : nil
  }
  
  func getBuyingLocationTextField() -> String? {
    let text = buyingLocationTextField.text?.trimmingCharacters(in: .whitespaces)
    
    return text?.count ?? -1 > 0 ? text : nil
  }
  
  func getMaterialImage() -> UIImage? { insertMaterialImageButton.imageView?.image }
  
}

extension DetailMaterialView: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    delegate?.numberOfComponents(in: pickerView) ?? 0
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    delegate?.pickerView(pickerView, numberOfRowsInComponent: component) ?? 0
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    delegate?.pickerView(pickerView, titleForRow: row, forComponent: component)
  }
}

extension DetailMaterialView: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    delegate?.pickerView(pickerView, didSelectRow: row, inComponent: component)
  }
}
