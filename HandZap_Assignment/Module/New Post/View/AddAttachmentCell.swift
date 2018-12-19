//
//  AddAttachmentCell.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

class AddAttachmentCell: UICollectionViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    
    public func setUpCell() {
        viewContent.layer.cornerRadius = 2
        viewContent.layer.masksToBounds = true
    }
}
