//
//  NewPostRouter.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

class NewPostRouter: NewPostWireframe {
    
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        
        let view: NewPostViewController = StoryBoard.newPostStoryBoard.instantiateViewController(withIdentifier: "NewPostViewController") as! NewPostViewController
        
        let presenter = NewPostPresenter()
        let interactor = NewPostInteractor()
        let router = NewPostRouter()
        
        let navigationController = UINavigationController.init(rootViewController: view)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigationController
        
    }
    
    func selectPostCategories(_ selectedCategoriesDelegate: PostCategoriesDelegate, _ selectedCategories: [String]) {
        if let selectCategoriesCtrl: PostCategoriesViewController = PostCategoriesRouter.assembleModule() as? PostCategoriesViewController {
            selectCategoriesCtrl.postCategoriesDelegate = selectedCategoriesDelegate
            selectCategoriesCtrl.selectedCategories = selectedCategories
            viewController?.navigationController?.pushViewController(selectCategoriesCtrl, animated: true)
        }
    }
}
