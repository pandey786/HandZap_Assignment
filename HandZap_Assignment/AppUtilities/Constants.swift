//
//  Constants.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    
}

enum StoryBoard {
    
    static var newPostStoryBoard: UIStoryboard {
        return UIStoryboard.init(name: "NewPostStoryboard", bundle: nil)
    }
    
    static var postCategoriesStoryBoard: UIStoryboard {
        return UIStoryboard.init(name: "PostCategoriesStoryboard", bundle: nil)
    }
}

enum NewPostInputField: NSInteger {
    case PostTitle
    case PostDescription
    case PostCategories
    case Currency
    case Budget
    case Rate
    case PaymentMethod
    case Location
    case StartDate
    case JobTerm
}

var currencyArray = ["No Preference", "INR", "USD"]
var paymentMethodArray = ["No Preference", "E-Payment", "Cash"]
var rateArray = ["No Preference", "Fixed Budget", "Hourly Rate"]
var jobTermArray = ["No Preference", "Same Day Job", "Multi Day Job", "Recurring Job"]
var startDateArray = ["No Preference", "Today", "Tomorrow", "This Week", "This Month"]

