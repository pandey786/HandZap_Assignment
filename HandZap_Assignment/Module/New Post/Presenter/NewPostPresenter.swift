//
//  NewPostPresenter.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

class NewPostPresenter: NewPostPresentation {
    
    var view: NewPostView?
    var interactor: NewPostUseCase!
    var router: NewPostWireframe!
    
}

extension NewPostPresenter: NewPostInteractorOutput {
    
}
