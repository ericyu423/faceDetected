//
//  ViewController.swift
//  photoCompare
//
//  Created by eric yu on 4/13/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var image: Any!
    
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
           imagePicker.sourceType = .camera
           imagePicker.cameraDevice = .front
         
            //transform = CGAffineTransformScale(image.transform, -1, 1);
            return imagePicker
        }()
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            present(imagePicker, animated: false, completion: nil)
        }
    }
    
 
    
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = info[UIImagePickerControllerEditedImage] ?? info[UIImagePickerControllerOriginalImage]
        //imageView.image = image as? UIImage

        let resizeImage = (image as! UIImage).resized(withPercentage: 0.5)
        let data = UIImagePNGRepresentation(resizeImage!)
        
        //covert back to image
        image = UIImage(data:data!,scale:1.0)
        //image = image as! UIImage
        let vp = VisionProcessor()
        if let imageToprocess = image as? UIImage
        {
            var msg = ""
           //print("number \(vp.numberFaceDetected(image: imageToprocess))")
            switch (vp.numberFaceDetected(image: imageToprocess)){
            case 0:
                msg = "no face detected, please retake photo"
            case 1:
                msg = ""
            case let x where x > 1:
                msg = "multiple faces detected, please retake photo"
 
            default:
                msg = "error, please retake photo"

            }
            
            
            dismiss(animated: true, completion: {

                
                let alertController = UIAlertController(title: "photo verification", message: msg, preferredStyle: .alert)
                
                 alertController.addImage(image: imageToprocess)
                
                if (vp.numberFaceDetected(image: imageToprocess) == 1){
                alertController.addAction(UIAlertAction(title: "Accepted", style: .default, handler: { _ in
                    //this should probably call the regular check-in
                }))
                }else{
                   
                    alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                        self.verifyUserImage()
                    }))
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
                        //does nothing
                    }))
                }
                
                
                
                self.present(alertController, animated: true, completion: nil)
               
            })
        }
        
      
        self.dismiss(animated: true, completion:nil)
        
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
        imgAction.setValue(resizeImage.withRenderingMode(.alwaysOriginal), forKey: "image")
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
