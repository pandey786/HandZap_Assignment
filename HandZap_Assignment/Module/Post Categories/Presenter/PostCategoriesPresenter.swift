//
//  PostCategoriesPresenter.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

class PostCategoriesPresenter: PostCategoriesPresentation {
    
    var view: PostCategoriesView?
    var interactor: PostCategoriesUseCase!
    var router: PostCategoriesWireframe!
    
}

extension PostCategoriesPresenter: PostCategoriesInteractorOutput {
    
}
