//
//  PhotoCaptureCell.swift
//  photoCompare
//
//  Created by eric yu on 4/20/18.
//  Copyright © 2018 eric yu. All rights reserved.
//


import UIKit

class PhotoCaptureCell: UICollectionViewCell {
    
    let userImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "photoImage"))
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.orange.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let takePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Take Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Next >>", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //nextButton.isHidden = true
        addSubview(userImageView)
        addSubview(takePhotoButton)
        addSubview(nextButton)
        
        //userImageView autolayout
        
        userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 70).isActive = true
        userImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        //image ratio passport 35x45
        userImageView.widthAnchor.constraint(equalToConstant: 350/1.2).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 450/1.2).isActive = true
        //userImageView autolayout ends
        
        
        
        //takePhotoButton autolayout
        takePhotoButton.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 50).isActive = true
        takePhotoButton.leftAnchor.constraint(equalTo: userImageView.leftAnchor, constant: 30).isActive = true
        takePhotoButton.rightAnchor.constraint(equalTo: userImageView.rightAnchor, constant: -30).isActive = true
        takePhotoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //takePhotoButton autolayout ends
        
        //nextButton autolayout
        nextButton.topAnchor.constraint(equalTo: takePhotoButton.bottomAnchor, constant: 30).isActive = true
        nextButton.leftAnchor.constraint(equalTo: takePhotoButton.leftAnchor, constant: 0).isActive = true
        nextButton.rightAnchor.constraint(equalTo: takePhotoButton.rightAnchor, constant: 0).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //nextButton autolayout ends
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
