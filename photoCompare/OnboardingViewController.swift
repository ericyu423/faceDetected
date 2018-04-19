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
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
    
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .red
        cv.dataSource = self
        cv.delegate = self
        
        cv.isPagingEnabled = true //snaps in place
    
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red
        
        view.addSubview(collectionView)
       
        //autolayout
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
       
       
    }
 

    
    //delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = .white
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
 
}







