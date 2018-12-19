//
//  CategoryCell.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCategory: UIImageView!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryTitle_Back: UILabel!
    
    public func flipCellWithoutAnimation(_ isSelected: Bool) {
        
        if isSelected {
            bringSubview(toFront: backView)
        } else {
            bringSubview(toFront: frontView)
        }
    }
    
    public func flipCell(_ isSelected: Bool, _ shouldAnimate: Bool) {

        let fromView = isSelected ? frontView : backView
        let toView = isSelected ? backView : frontView
        let flipDirection: UIViewAnimationOptions = isSelected ? .transitionFlipFromRight : .transitionFlipFromLeft
        let options: UIViewAnimationOptions = [flipDirection, .showHideTransitionViews]
        let duration = shouldAnimate ? 0.6: 0
        UIView.transition(from: fromView!, to: toView!, duration: duration, options: options) {
            finished in
        }
    }
    
}
