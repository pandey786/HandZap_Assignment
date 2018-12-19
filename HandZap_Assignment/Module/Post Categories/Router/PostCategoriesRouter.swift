//
//  PostCategoriesRouter.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

class PostCategoriesRouter: PostCategoriesWireframe {
    
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        
        let view: PostCategoriesViewController = StoryBoard.postCategoriesStoryBoard.instantiateViewController(withIdentifier: "PostCategoriesViewController") as! PostCategoriesViewController
        
        let presenter = PostCategoriesPresenter()
        let interactor = PostCategoriesInteractor()
        let router = PostCategoriesRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return view
        
    }
}
