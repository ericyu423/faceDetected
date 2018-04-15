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
        accessIphoneCamera()
    }
    
    private func accessIphoneCamera(){
        let imagePicker: UIImagePickerController = {
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = false
           imagePicker.sourceType = .camera
           imagePicker.cameraDevice = .front
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
        imageView.image = image as? UIImage

        let resizeImage = (image as! UIImage).resized(withPercentage: 0.5)
        let data = UIImagePNGRepresentation(resizeImage!)
        
        //covert back to image
        image = UIImage(data:data!,scale:1.0)
        let vp = VisionProcessor()
        if let imageToprocess = image as? UIImage
        {
           print("name \(vp.numberFaceDetected(image: imageToprocess))")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
