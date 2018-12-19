//
//  PostCategoriesViewController.swift
//  HandZap_Assignment
//
//  Created by Durgesh Pandey on 19/12/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit

class PostCategoriesViewController: UIViewController {
    
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    @IBOutlet weak var stackViewSelectedCategories: UIStackView!
    @IBOutlet weak var viewCurrentSelected: UIView!
    @IBOutlet weak var viewMaxSelected: UIView!
    @IBOutlet weak var labelCurrentSelected: UILabel!
    @IBOutlet weak var labelMaxSelected: UILabel!
    @IBOutlet weak var buttonSelectCategories: UIBarButtonItem!
    
    public var postCategoriesDelegate: PostCategoriesDelegate?
    var presenter: PostCategoriesPresentation!
    var categoriesArray = [String]()
    public var selectedCategories = [String]()
    let maxCategoriesSelection = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetUp()
        categoriesArray = createDataSource()
        collectionViewCategories.reloadData()
    }
    
    private func createDataSource() -> [String] {
        var dataSourceArray = [String]()
        for i in 0...26 {
            dataSourceArray.append("C \(i)")
        }
        return dataSourceArray
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSelectCategoriesTapped(_ sender: Any) {
        postCategoriesDelegate?.selectedPostCategories(selectedCategories)
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - View Setup
// MARK: -
extension PostCategoriesViewController {
    
    fileprivate func viewSetUp() {
        customizeNavigationBar()
        checkIfSelectButtonShouldbeEnabled()
        setUpSelectedCategoriesLabel()
    }
    
    fileprivate func customizeNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.init(named: "BottomSeparatorEditMode")
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    fileprivate func setUpSelectedCategoriesLabel() {
        
        if selectedCategories.count > 0 {
            stackViewSelectedCategories.addArrangedSubview(viewMaxSelected)
            labelCurrentSelected.text = "\(selectedCategories.count) selected"
            labelMaxSelected.text = "Maximim \(maxCategoriesSelection) Categories"
        } else {
            stackViewSelectedCategories.removeArrangedSubview(viewMaxSelected)
            labelCurrentSelected.text = "Select upto \(maxCategoriesSelection) Catgories"
        }
    }
    
    fileprivate func checkIfSelectButtonShouldbeEnabled() {
        buttonSelectCategories.isEnabled = selectedCategories.count > 0 ? true: false
    }
}

// MARK: - Collection View
// MARK: -
extension PostCategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let categoryCell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
            
            let categoryStr = categoriesArray[indexPath.row]
            categoryCell.categoryTitle.text = categoryStr
            categoryCell.categoryTitle_Back.text = categoryStr
            categoryCell.flipCell(selectedCategories.contains(categoryStr), false)
            
            return categoryCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (collectionView.frame.size.width/3 - 1.5), height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell: CategoryCell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            
            if selectedCategories.contains(categoriesArray[indexPath.item]), let index = selectedCategories.index(of: categoriesArray[indexPath.item]) {
                selectedCategories.remove(at: index)
                cell.flipCell(false, true)
            } else {
                
                if selectedCategories.count < maxCategoriesSelection {
                    selectedCategories.append(categoriesArray[indexPath.item])
                    cell.flipCell(true, true)
                }
            }
            
            setUpSelectedCategoriesLabel()
            checkIfSelectButtonShouldbeEnabled()
        }
    }
}

extension PostCategoriesViewController: PostCategoriesView {
    
}
