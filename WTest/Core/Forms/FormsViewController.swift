//
//  FormsViewController.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class FormsViewController: UIViewController {
    
    private var viewModel = FormsViewModel()
    
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var bodyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var statusTextField: TextFieldCustom = {
       let textField = TextFieldCustom("Qualidade", self)
        textField.inputView = pickerView
        return textField
    }()
    
    private lazy var dateTextField: TextFieldCustom = {
       let textField = TextFieldCustom("Domingo, 4 de Novembro de 2018", self)
        textField.inputView = datePicker
        return textField
    }()
    
    private lazy var validateButton: UIButton = {
       let button = UIButton()
        button.setTitle("Validar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var descriptionTextField = TextFieldCustom("Texto livre...", self)
    private lazy var emailTextField = TextFieldCustom("email@example.com", self)
    private lazy var idTextField = TextFieldCustom("0000...", self)
    private lazy var textTextField = TextFieldCustom("AAAA-AA", self)

    private let pickerView = UIPickerView()
    private var pickerList: [String] = []
    
    private let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        configDatePicker()
        configCloseKeyboard()
        configPickerView()
        setScrolViewInView()
        setBodyViewInScrollView()
        setStackViewInBodyView()
        setFieldsInStackView()
        setValidateButtonInStackView()
    }
    
    private func configDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(selectDate), for: .valueChanged)
        dismissPickerView(dateTextField)
    }
    
    private func configCloseKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        scrollView.addGestureRecognizer(tap)
        scrollView.isUserInteractionEnabled = true
    }
    
    private func configPickerView() {
        pickerList = ["Mau", "Satisfatório", "Bom", "Muito Bom", "Excelente"]
        pickerView.delegate = self
        pickerView.dataSource = self
        dismissPickerView(statusTextField)
    }
    
    private func setScrolViewInView() {
        view.addSubviews([scrollView])
        
        scrollView.edgeToSuperView()
            .centerX(of: view)
    }
    
    private func setBodyViewInScrollView() {
        scrollView.addSubviews([bodyView])
        
        bodyView.topToTop(of: scrollView)
            .bottomToBotton(of: scrollView)
            .leadingToLeading(of: view)
            .trailingToTrailing(of: view)
    }
    
    private func setStackViewInBodyView() {
        bodyView.addSubviews([stackView])
        
        stackView.edgeToSuperView(margin: 16)
    }
    
    private func setFieldsInStackView() {
        stackView.addArrangedSubview(descriptionTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(idTextField)
        stackView.addArrangedSubview(textTextField)
        stackView.addArrangedSubview(dateTextField)
        stackView.addArrangedSubview(statusTextField)
    }
    
    private func setValidateButtonInStackView() {
        validateButton.addTarget(self, action: #selector(validateActionButton), for: .touchUpInside)
        stackView.addArrangedSubview(validateButton)
        stackView.setCustomSpacing(16, after: statusTextField)
        
        validateButton.height(50)
    }
    
    private func dismissPickerView(_ textField: UITextField) {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closeKeyboard))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       textField.inputAccessoryView = toolBar
    }
    
    private func setFileErrorEmpty(_ textField: UITextField) {
        var isValidTextField = true
        switch textField {
        case emailTextField:
            isValidTextField = textField.text?.isValidEmail ?? false
        case textTextField:
            isValidTextField = textField.text?.isValidText ?? false
        default:
            isValidTextField = textField.text?.isEmpty ?? false
        }
        
        textField.layer.borderColor = isValidTextField ?
            UIColor.black.cgColor : UIColor.red.cgColor
    }
    
    @objc private func selectDate() {
        if viewModel.isMonday(date: datePicker.date) {
            datePicker.setDate(datePicker.date - 1, animated: true)
        }
        
        dateTextField.text = datePicker.date.toLongDateString()
        viewModel.date = dateTextField.text ?? ""
    }
    
    @objc private func closeKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func validateActionButton() {
        closeKeyboard()
        if viewModel.isValidFields() {
            AlertCustom.showAlert(from: self, title: "Valid", message: "All fields are valid")
        } else {
            AlertCustom.showAlert(from: self, title: "Not valid", message: "Some fields are not valid")
        }
    }
}

extension FormsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == statusTextField ||
            textField == dateTextField {
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case descriptionTextField:
            viewModel.description = textField.text ?? ""
        case emailTextField:
            viewModel.email = textField.text ?? ""
        case idTextField:
            viewModel.idText = textField.text ?? ""
        case textTextField:
            viewModel.text = textField.text ?? ""
        default:
            break
        }
        
        setFileErrorEmpty(textField)
    }
}

extension FormsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusTextField.text = pickerList[row]
        viewModel.status = statusTextField.text ?? ""
    }
}
