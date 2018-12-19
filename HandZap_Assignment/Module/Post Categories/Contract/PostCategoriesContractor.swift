//
//  PostCategoriesContractor.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

public protocol PostCategoriesDelegate: class {
    func selectedPostCategories(_ postCategories: [String])
}

protocol PostCategoriesView: class {
    
    var presenter: PostCategoriesPresentation!{ get set }
}

protocol PostCategoriesPresentation: class {
    
    var view: PostCategoriesView? { get set }
    var interactor: PostCategoriesUseCase! { get set }
    var router: PostCategoriesWireframe! { get set }
}

protocol PostCategoriesUseCase: class {
    
    var output: PostCategoriesInteractorOutput! { get set }
}

protocol PostCategoriesInteractorOutput: class {
    
}

protocol PostCategoriesWireframe: class {
    
    var viewController: UIViewController? { get set }
    
    static func assembleModule() -> UIViewController
}
