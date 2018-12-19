//
//  NewPostContractor.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

protocol NewPostView: class {
    
    var presenter: NewPostPresentation!{ get set }
}

protocol NewPostPresentation: class {
    
    var view: NewPostView? { get set }
    var interactor: NewPostUseCase! { get set }
    var router: NewPostWireframe! { get set }
}

protocol NewPostUseCase: class {
    
    var output: NewPostInteractorOutput! { get set }
}

protocol NewPostInteractorOutput: class {
    
}

protocol NewPostWireframe: class {
    
    var viewController: UIViewController? { get set }
    
    func selectPostCategories(_ selectedCategoriesDelegate: PostCategoriesDelegate, _ selectedCategories: [String])
    static func assembleModule() -> UIViewController
}
