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
    let photoCell = "photoCell"
    
    let pages: [Page] = {
        let page1 = Page(title: "Title 1", message: "Introduce the App to the user here and provide images on top ", imageName: "onboarding1")
        let page2 = Page(title: "Title 2", message: "Introduce the App to the user here and provide images on top ", imageName: "onboarding1")
        let page3 = Page(title: "Title 3", message: "Introduce the App to the user here and provide images on top ", imageName: "onboarding1")
        
        return [page1,page2,page3]
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .blue
        pc.numberOfPages = self.pages.count + 1
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
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCellForDifferentOnboardingPageStyle()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        //autolayout collection View
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //autolayout collection View ends
        
        
        //autolayout pageController
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //autolayout pageController ends
        
        
        //autolayout left skip button
        skipButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 16).isActive = true
        
        skipButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //autolayout left skip button end
        
        
        //autolayout next button
        nextButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 16).isActive = true
        
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //autolayout skip button ends
        
    }
    
    //MARK - CollectionView Functions
    private func registerCellForDifferentOnboardingPageStyle(){
        
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(PhotoCaptureCell.self, forCellWithReuseIdentifier: photoCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1 //+1 for the extra takephoto style Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //at last page show photo capture page
        if indexPath.item == pages.count {
            let photoCaptureCell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath)
            return photoCaptureCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCollectionViewCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

//rotation
extension OnboardingViewController {
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

//control page view dot transition
extension OnboardingViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = collectionView.indexPathsForVisibleItems[0].item
        pageControl.currentPage = pageNumber
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if pageNumber == self.pages.count {
                self.pageControl.transform = CGAffineTransform(translationX: 0, y: 50)
                self.skipButton.transform = CGAffineTransform(translationX: 0, y: -60)
                self.nextButton.transform = CGAffineTransform(translationX: 0, y: -60)
            } else {
                //back on regular pages
                self.pageControl.transform = .identity
                self.skipButton.transform =  .identity
                self.nextButton.transform =  .identity
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
}





// this is another way to get pageNumber
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
//        pageControl.currentPage = pageNumber
//    }
    

