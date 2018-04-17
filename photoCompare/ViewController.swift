//
//  ViewController.swift
//  photoCompare
//
//  Created by eric yu on 4/13/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func takePhoto(_ sender: UIButton) {
        verifyUserImage()
    }
    
    
    private func verifyUserImage(){
        accessIphoneCamera()
    }
    
    
    private func accessIphoneCamera(){
        let imagePicker: UIImagePickerController = {
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = false
         
         
            return imagePicker
        }()
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.cameraDevice = .front
            present(imagePicker, animated: false, completion: nil)
        }else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.sourceType = .photoLibrary
             present(imagePicker, animated: false, completion: nil)
        }
    }
    
 
    
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    var imageFile: Any!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
  
        imageFile = info[UIImagePickerControllerOriginalImage]

        guard let image = imageFile as? UIImage else {
            return
        }
  
        let vp = VisionProcessor()
        let faceCount = vp.numberFaceDetected(image: image)
       

            var msg = ""
        
            switch faceCount {
            case 0:
                msg = "no face detected, please retake photo\n"
            case 1:
                msg = ""
            case let x where x > 1:
                msg = "multiple faces detected, please retake photo\n"
 
            default:
                msg = "error, please retake photo\n"

            }
            
            
            dismiss(animated: true, completion: {

                
                let numberOfBlankLines = 12
                let maxImageSize = CGSize(width: numberOfBlankLines * 16 , height: numberOfBlankLines * 16) //about 16 pt per return character
                let returnCharacters = String(repeating: "\n", count: numberOfBlankLines)
                let alertController = UIAlertController(title: "photo verification", message: msg + returnCharacters, preferredStyle: .alert)
        
                let imageView = UIImageView(image: image)
                
                let scaleSize = self.imageScaleSize(maxSize: maxImageSize ,image:image)
                
                 alertController.view.addSubview(imageView)
                
    
                if (faceCount == 1){
                alertController.addAction(UIAlertAction(title: "Accepted", style: .default, handler: { _ in
                    //this should probably call the regular check-in
                }))
                }else{
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                        //does nothing
                    }))
                    alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                        self.verifyUserImage()
                    }))
                  
                }
          
                imageView.translatesAutoresizingMaskIntoConstraints = false
                alertController.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: alertController.view, attribute: .centerX, multiplier: 1, constant: 0))
                alertController.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: alertController.view, attribute: .centerY, multiplier: 1, constant: 0))
                alertController.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: scaleSize.width ))
                alertController.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: scaleSize.height ))
                
                self.present(alertController, animated: true, completion: nil)
               
            })//dimiss completion ends
        
        
      
        self.dismiss(animated: true, completion:nil)
        
    }
    private func imageScaleSize(maxSize: CGSize,image:UIImage?)->CGSize {
        
        let imgSize = image?.size ?? maxSize
        
        var ratio:CGFloat!
        if(imgSize.width > imgSize.height){
            ratio = maxSize.width/imgSize.width
        }else {
            ratio = maxSize.height / imgSize.height
        }
        
        let scaleSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        
        return scaleSize
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



}

extension UIAlertController {
    
   
    func addImage(image: UIImage) {
        let maxSize = CGSize(width: 200, height: 200)
        let imgSize = image.size
        var ratio:CGFloat!
        if(imgSize.width > imgSize.height){
            ratio = maxSize.width/imgSize.width
        }else {
           ratio = maxSize.height / imgSize.height
        }
        let scaleSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        let resizeImage = image.imageWithSize(scaleSize)

        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        
        imgAction.setValue(image, forKey: "image")
        
        //image is private no good
     
    
        self.addAction(imgAction)
     
    }
    
}


extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func imageWithSize(_ size:CGSize) -> UIImage {
        var scaledImageRect = CGRect.zero
        
        let aspectWidth:CGFloat = size.width / self.size.width
        let aspectHeight:CGFloat = size.height / self.size.height
        let aspectRatio:CGFloat = min(aspectWidth, aspectHeight)
        
        scaledImageRect.size.width = self.size.width * aspectRatio
        scaledImageRect.size.height = self.size.height * aspectRatio
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        self.draw(in: scaledImageRect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}
