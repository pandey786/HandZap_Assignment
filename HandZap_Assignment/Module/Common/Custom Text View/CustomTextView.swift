//
//  CustomTextView.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

public class CustomTextView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak public var labelInputFieldTitle: UILabel!
    @IBOutlet weak public var textViewInputField: UITextView!
    @IBOutlet weak public var viewInputBottomIndicator: UIView!
    @IBOutlet weak public var labelCharactersLeft: UILabel!
    @IBOutlet weak var labelPlaceholder: UILabel!
    
    @IBOutlet weak var constraintInputFieldTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintCharactersleftHeight: NSLayoutConstraint!
    
    public var shouldShowCharactersLeft = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomTextView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    public func setUpInputFieldView(parentView: UIView) {
        self.layoutSetup(parentView: parentView)
    }
    
    public func enterEditMode() {
        
        layoutIfNeeded()
        UIView.animate(withDuration: 0.1) { [weak self] in
            
            guard let weakSelf = self else { return }
            weakSelf.constraintInputFieldTitleHeight.constant = 15
            weakSelf.constraintCharactersleftHeight.constant =  weakSelf.shouldShowCharactersLeft ? 15: 0
            weakSelf.viewInputBottomIndicator.backgroundColor = UIColor.init(named: "BottomSeparatorEditMode")
            weakSelf.labelPlaceholder.isHidden = true
            weakSelf.layoutIfNeeded()
        }
    }
    
    public func exitEditMode() {
        layoutIfNeeded()
        UIView.animate(withDuration: 0.1) { [weak self] in
            
            guard let weakSelf = self else { return }
            
            weakSelf.constraintCharactersleftHeight.constant = 0
            weakSelf.viewInputBottomIndicator.backgroundColor = UIColor.init(named: "BottomSeparatorViewMode")
            
            if let currentText = weakSelf.textViewInputField.text {
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
