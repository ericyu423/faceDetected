//
//  OnboardingViewController.swift
//  photoCompare
//
//  Created by eric yu on 4/19/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    let cellId = "cell"
    
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .blue
        pc.numberOfPages = pages.count
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
    
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        
        cv.isPagingEnabled = true //snaps in place
    
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        //autolayout
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //autolayout ends
        
        

    }
 

    let pages: [Page] = {
        let page1 = Page(title: "Title 1", message: "Introduce the App to the user here and provide images on top ", imageName: "onboarding1")
         let page2 = Page(title: "Title 2", message: "Introduce the App to the user here and provide images on top ", imageName: "onboarding1")
         let page3 = Page(title: "Title 3", message: "Introduce the App to the user here and provide images on top ", imageName: "onboarding1")

        return [page1,page2,page3]

    }()
    //MARK - Delegate Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCollectionViewCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
 
}







