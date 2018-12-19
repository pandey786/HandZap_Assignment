//
//  AttachmentCell.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

class AttachmentCell: UICollectionViewCell {
    
    @IBOutlet weak var viewImage: UIImageView!
    
    public func setUpCell() {
        viewImage.layer.cornerRadius = 2
        viewImage.layer.masksToBounds = true
    }
}
