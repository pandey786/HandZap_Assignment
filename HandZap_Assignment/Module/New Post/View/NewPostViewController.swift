//
//  NewPostViewController.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {
    
    var presenter: NewPostPresentation!
    
    @IBOutlet weak var postTitleInputFieldView: CustomTextField!
    @IBOutlet weak var postTitleInputFieldViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postDescriptionInputFieldView: CustomTextView!
    @IBOutlet weak var postDescriptionInputFieldViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectLocationInputField: CustomTextField!
    @IBOutlet weak var postCategoriesInputField: CustomTextField!
    @IBOutlet weak var budgetInputFieldView: CustomTextField!
    @IBOutlet weak var jobTermPicker: CustomDataPicker!
    @IBOutlet weak var startDatePicker: CustomDataPicker!
    @IBOutlet weak var paymentMethodPicker: CustomDataPicker!
    @IBOutlet weak var ratePicker: CustomDataPicker!
    @IBOutlet weak var currencyPicker: CustomDataPicker!
    @IBOutlet weak var collectionViewPostAttachments: UICollectionView!
    @IBOutlet weak var buttonPost: UIBarButtonItem!
    
    public var userData = UserData()
    
    var selectedCategories = [String]()
    let maxCharacters_PostTitle = 50
    let maxCharacters_PostDescription = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetUp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonPostTapped(_ sender: Any) {
    }
}

// MARK: - View Setup
// MARK: -
extension NewPostViewController {
    
    fileprivate func viewSetUp() {
        disableFixedHeightConstraints()
        customizeNavigationBar()
        checkIfPostButtonShouldBeEnabled()
        
        // Post Title
        postTitleInputFieldView.labelInputFieldTitle.text = "Post Title"
        postTitleInputFieldView.labelPlaceholder.text = "Enter Post Title"
        postTitleInputFieldView.textFieldInputField.delegate = self
        postTitleInputFieldView.textFieldInputField.tag = NewPostInputField.PostTitle.rawValue
        postTitleInputFieldView.shouldShowCharactersLeft = true
        postTitleInputFieldView.imageViewFieldMarker.isHidden = true
        postTitleInputFieldView.labelCharactersLeft.text = "\(maxCharacters_PostTitle) characters left"
        postTitleInputFieldView.exitEditMode()
        
        // Post Description
        postDescriptionInputFieldView.labelInputFieldTitle.text = "Post Description"
        postDescriptionInputFieldView.labelPlaceholder.text = "Describe Your Post"
        postDescriptionInputFieldView.textViewInputField.delegate = self
        postDescriptionInputFieldView.textViewInputField.tag = NewPostInputField.PostDescription.rawValue
        postDescriptionInputFieldView.shouldShowCharactersLeft = true
        postDescriptionInputFieldView.labelCharactersLeft.text = "\(maxCharacters_PostDescription) characters left"
        postDescriptionInputFieldView.exitEditMode()
        
        //Categories
        postCategoriesInputField.labelInputFieldTitle.text = "Post Title"
        postCategoriesInputField.labelPlaceholder.text = "Select Post Categories"
        postCategoriesInputField.textFieldInputField.delegate = self
        postCategoriesInputField.textFieldInputField.tag = NewPostInputField.PostCategories.rawValue
        postCategoriesInputField.imageViewFieldMarker.isHidden = false
        postCategoriesInputField.imageViewFieldMarker.image = UIImage.init(named: "category")
        postCategoriesInputField.exitEditMode()
        
        // Currency
        currencyPicker.pickerDelegate = self
        currencyPicker.pickerDataSource = currencyArray
        currencyPicker.labelInputFieldTitle.text = "Currency"
        currencyPicker.labelPlaceholder.text = "Currency"
        currencyPicker.textFieldInputField.delegate = self
        currencyPicker.textFieldInputField.tag = NewPostInputField.Currency.rawValue
        currencyPicker.exitEditMode()
        
        // Budget
        budgetInputFieldView.labelInputFieldTitle.text = "Post Title"
        budgetInputFieldView.labelPlaceholder.text = "Budget"
        budgetInputFieldView.textFieldInputField.delegate = self
        budgetInputFieldView.textFieldInputField.tag = NewPostInputField.Budget.rawValue
        budgetInputFieldView.imageViewFieldMarker.isHidden = true
        budgetInputFieldView.exitEditMode()
        
        // Rate
        ratePicker.pickerDelegate = self
        ratePicker.pickerDataSource = rateArray
        ratePicker.labelInputFieldTitle.text = "Rate"
        ratePicker.labelPlaceholder.text = "Rate"
        ratePicker.textFieldInputField.delegate = self
        ratePicker.textFieldInputField.tag = NewPostInputField.Rate.rawValue
        ratePicker.exitEditMode()
        
        // Payment Method
        paymentMethodPicker.pickerDelegate = self
        paymentMethodPicker.pickerDataSource = paymentMethodArray
        paymentMethodPicker.labelInputFieldTitle.text = "Payment Method"
        paymentMethodPicker.labelPlaceholder.text = "Payment Method"
        paymentMethodPicker.textFieldInputField.delegate = self
        paymentMethodPicker.textFieldInputField.tag = NewPostInputField.PaymentMethod.rawValue
        paymentMethodPicker.exitEditMode()
        
        // Location
        selectLocationInputField.labelInputFieldTitle.text = "Set Location"
        selectLocationInputField.labelPlaceholder.text = "Set Location"
        selectLocationInputField.textFieldInputField.delegate = self
        selectLocationInputField.imageViewFieldMarker.isHidden = false
        selectLocationInputField.imageViewFieldMarker.image = UIImage.init(named: "location")
        selectLocationInputField.textFieldInputField.tag = NewPostInputField.Location.rawValue
        selectLocationInputField.exitEditMode()
        
        // Start Date
        startDatePicker.pickerDelegate = self
        startDatePicker.pickerDataSource = startDateArray
        startDatePicker.labelInputFieldTitle.text = "Start Date"
        startDatePicker.labelPlaceholder.text = "Start Date"
        startDatePicker.textFieldInputField.delegate = self
        startDatePicker.textFieldInputField.tag = NewPostInputField.StartDate.rawValue
        startDatePicker.exitEditMode()
        
        // Currency
        jobTermPicker.pickerDelegate = self
        jobTermPicker.pickerDataSource = jobTermArray
        jobTermPicker.labelInputFieldTitle.text = "Job Term"
        jobTermPicker.labelPlaceholder.text = "Job Term"
        jobTermPicker.textFieldInputField.delegate = self
        jobTermPicker.textFieldInputField.tag = NewPostInputField.JobTerm.rawValue
        jobTermPicker.exitEditMode()
    }
    
    fileprivate func customizeNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.init(named: "BottomSeparatorEditMode")
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    fileprivate func disableFixedHeightConstraints() {
        postTitleInputFieldViewHeightConstraint.isActive = false
        postDescriptionInputFieldViewHeightConstraint.isActive = false
    }
    
    fileprivate func enterEditMode(_ inputFieldTag: NSInteger) {
        
        switch inputFieldTag {
        case NewPostInputField.PostTitle.rawValue:
            postTitleInputFieldView.enterEditMode()
        case NewPostInputField.PostDescription.rawValue:
            postDescriptionInputFieldView.enterEditMode()
        case NewPostInputField.Currency.rawValue:
            currencyPicker.enterEditMode()
        case NewPostInputField.Budget.rawValue:
            budgetInputFieldView.enterEditMode()
        case NewPostInputField.Rate.rawValue:
            ratePicker.enterEditMode()
        case NewPostInputField.PaymentMethod.rawValue:
            paymentMethodPicker.enterEditMode()
        case NewPostInputField.StartDate.rawValue:
            startDatePicker.enterEditMode()
        case NewPostInputField.JobTerm.rawValue:
            jobTermPicker.enterEditMode()
        default:
            break
        }
    }
    
    fileprivate func exitEditMode(_ inputFieldTag: NSInteger) {
        
        switch inputFieldTag {
        case NewPostInputField.PostTitle.rawValue:
            userData.postTitle = postTitleInputFieldView.textFieldInputField.text
            postTitleInputFieldView.exitEditMode()
        case NewPostInputField.PostDescription.rawValue:
            userData.postDescription = postDescriptionInputFieldView.textViewInputField.text
            postDescriptionInputFieldView.exitEditMode()
        case NewPostInputField.Currency.rawValue:
            userData.postCurrency = currencyPicker.textFieldInputField.text
            currencyPicker.exitEditMode()
        case NewPostInputField.Budget.rawValue:
            userData.postBudget = budgetInputFieldView.textFieldInputField.text
            budgetInputFieldView.exitEditMode()
        case NewPostInputField.Rate.rawValue:
            userData.postRate = ratePicker.textFieldInputField.text
            ratePicker.exitEditMode()
        case NewPostInputField.PaymentMethod.rawValue:
            userData.postPaymentMetod = paymentMethodPicker.textFieldInputField.text
            paymentMethodPicker.exitEditMode()
        case NewPostInputField.StartDate.rawValue:
            userData.postStartDate = startDatePicker.textFieldInputField.text
            startDatePicker.exitEditMode()
        case NewPostInputField.JobTerm.rawValue:
            userData.postJobterm = jobTermPicker.textFieldInputField.text
            jobTermPicker.exitEditMode()
        default:
            break
        }
    }
    
    fileprivate func checkIfPostButtonShouldBeEnabled() {
        
    }
}

// MARK: - CustomDataPickerDelegate
// MARK: -
extension NewPostViewController: CustomDataPickerDelegate {
    
    func customDataPicker(_ dataPicker: CustomDataPicker, didSelectItem selectedItem: String) {
        switch dataPicker {
        case currencyPicker:
            currencyPicker.textFieldInputField.text = selectedItem
        case ratePicker:
            ratePicker.textFieldInputField.text = selectedItem
        case paymentMethodPicker:
            paymentMethodPicker.textFieldInputField.text = selectedItem
        case startDatePicker:
            startDatePicker.textFieldInputField.text = selectedItem
        case jobTermPicker:
            jobTermPicker.textFieldInputField.text = selectedItem
        default:
            break
        }
    }
}

// MARK: - UITextFieldDelegate
// MARK: -
extension NewPostViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == NewPostInputField.PostCategories.rawValue {
            
            //Navigate to Select PostCatgories
            presenter.router.selectPostCategories(self, selectedCategories)
            
            return false
        } else if textField.tag == NewPostInputField.Location.rawValue {
            //Navigate to Select Location
            return false
        } else {
            enterEditMode(textField.tag)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            let textCount = updatedText.count
            
            if textField.tag == NewPostInputField.PostTitle.rawValue {
                
                if textCount < (maxCharacters_PostTitle + 1) {
                    postTitleInputFieldView.labelCharactersLeft.text = "\(maxCharacters_PostTitle - textCount) characters left"
                    return true
                } else {
                    return false
                }
            }
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        exitEditMode(textField.tag)
        return true
    }
}

// MARK: - UitextViewDelegate
// MARK: -
extension NewPostViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        enterEditMode(textView.tag)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        exitEditMode(textView.tag)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if let text = textView.text,
            let textRange = Range(range, in: text) {
            
            let updatedText = text.replacingCharacters(in: textRange, with: text)
            let textCount = updatedText.count
            if textView.tag == NewPostInputField.PostDescription.rawValue {
                if textCount < (maxCharacters_PostDescription + 1) {
                    postDescriptionInputFieldView.labelCharactersLeft.text = "\(maxCharacters_PostDescription - textCount) characters left"
                    return true
                } else {
                    return false
                }
            }
        }
        
        return true
    }
}

// MARK: - NewPostView
// MARK: -
extension NewPostViewController: NewPostView {
    
}

// MARK: - Post Attachments Collection View
// MARK: -
extension NewPostViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userData.postAttachments.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            
            if let addAttachmentCell: AddAttachmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddAttachmentCell", for: indexPath) as? AddAttachmentCell {
                
                addAttachmentCell.setUpCell()
                return addAttachmentCell
            }
        } else {
            
            if let attachmentCell: AttachmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachmentCell", for: indexPath) as? AttachmentCell {
                attachmentCell.viewImage.image = userData.postAttachments[indexPath.item - 1]
                attachmentCell.setUpCell()
                return attachmentCell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 80.0, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            
            let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                self.openGallery()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Image Picker
// MARK: -
extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userData.postAttachments.append(pickedImage)
            collectionViewPostAttachments.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Post Categories Selection
// MARK: -
extension NewPostViewController: PostCategoriesDelegate {
    
    func selectedPostCategories(_ postCategories: [String]) {
        selectedCategories = postCategories
        postCategoriesInputField.textFieldInputField.text = "\(postCategories.count) Categories selected"
        postCategoriesInputField.enterEditMode()
    }
}
