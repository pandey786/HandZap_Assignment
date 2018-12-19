//
//  CustomDataPicker.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

public protocol CustomDataPickerDelegate: class {
    func customDataPicker(_ dataPicker: CustomDataPicker, didSelectItem selectedItem: String)
}

public class CustomDataPicker: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak public var labelInputFieldTitle: UILabel!
    @IBOutlet weak public var textFieldInputField: UITextField!
    @IBOutlet weak public var viewInputBottomIndicator: UIView!
    @IBOutlet weak public var labelPlaceholder: UILabel!
    @IBOutlet weak var constraintInputFieldTitleHeight: NSLayoutConstraint!
    
    public var pickerDataSource = [String]()
    weak public var pickerDelegate: CustomDataPickerDelegate?
    
    var pickerView: UIPickerView {
        get {
            let pickerView = UIPickerView()
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.backgroundColor = UIColor.white
            return pickerView
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    @objc func onDoneButtonTapped(sender: UIBarButtonItem) {
        if textFieldInputField.isFirstResponder {
            textFieldInputField.resignFirstResponder()
        }
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomDataPicker", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        textFieldInputField.inputView = pickerView
    }
    
    public func setUpInputFieldView(parentView: UIView) {
        self.layoutSetup(parentView: parentView)
    }
    
    public func enterEditMode() {
        
        layoutIfNeeded()
        UIView.animate(withDuration: 0.1) { [weak self] in
            
            guard let weakSelf = self else { return }
            weakSelf.constraintInputFieldTitleHeight.constant = 15
            weakSelf.labelPlaceholder.isHidden = true
            weakSelf.viewInputBottomIndicator.backgroundColor = UIColor.init(named: "BottomSeparatorEditMode")
            weakSelf.layoutIfNeeded()
        }
    }
    
    public func exitEditMode() {
        layoutIfNeeded()
        UIView.animate(withDuration: 0.1) { [weak self] in
            
            guard let weakSelf = self else { return }
            
            weakSelf.viewInputBottomIndicator.backgroundColor = UIColor.init(named: "BottomSeparatorViewMode")
            
            if let currentText = weakSelf.textFieldInputField.text {
                weakSelf.labelPlaceholder.isHidden = currentText.isEmpty ? false: true
                weakSelf.constraintInputFieldTitleHeight.constant = currentText.isEmpty ? 0: 15
            }
            
            weakSelf.layoutIfNeeded()
        }
    }
    
    private func layoutSetup(parentView: UIView) {
        
        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: parentView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: parentView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: parentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: parentView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        parentView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
}

extension CustomDataPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           titleForRow row: Int,
                           forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                           didSelectRow row: Int,
                           inComponent component: Int) {
        pickerDelegate?.customDataPicker(self, didSelectItem: pickerDataSource[row])
    }
}
