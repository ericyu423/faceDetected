//
//  PageCollectionViewCell.swift
//  photoCompare
//
//  Created by eric yu on 4/19/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }
            imageView.image = UIImage(named: page.imageName)
            let color = UIColor(white: 0.2, alpha: 1)
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor: color])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.count
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "onboarding1")
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tv.text = "text goes here..."
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    
    
    func setupViews(){

        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
            
        //autolayout image
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        //autolayout image ends
        
        //autolayout textView
        textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        //autolayout textView ends
        
        //autolayout lineSeperator
        lineSeparatorView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: 0).isActive = true
        lineSeparatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        lineSeparatorView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        //autolayout lineseperator ends
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
