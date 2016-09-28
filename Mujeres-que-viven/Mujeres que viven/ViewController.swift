//
//  ViewController.swift
//  Mujeres que viven
//
//  Created by Salvador De La Rosa on 9/1/16.
//  Copyright © 2016 Magnolia Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
 //   @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomText: UITextField!
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.enabled = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    let imagePicker = UIImagePickerController()
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.whiteColor(),
        NSForegroundColorAttributeName: UIColor.init(red: 0.96, green: 0.35, blue: 0.65, alpha: 1.0),
       // NSForegroundColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName : UIFont(name: "KingBasilLite-Regular", size: 30)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
        setupTextField(bottomText)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera);
        shareButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupTextField(textField: UITextField!) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.delegate = self
    }

    func pickAnImageFromSource(source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
                pickAnImageFromSource(.PhotoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
                pickAnImageFromSource(.Camera)
    }
    
    @IBAction func shareImage(sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(activityViewController, animated: true, completion: nil)
        
    }

    func save() {
        
        //Create the meme
        let meme = Image(bottomText: bottomText.text!, image: imagePickerView.image!, memedImage: generateMemedImage())
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        toolBar.hidden = true
      //  navigationBar.hidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
    //    navigationBar.hidden = false
        
        return memedImage
    }
    
}


//Configure UI
extension ViewController {
    
    private func configureBackground() {
        let backgroundGradient = CAGradientLayer()
        let colorTop = UIColor(red:0.97, green:0.90, blue:0.79, alpha:1.0).CGColor
        let colorBottom = UIColor(red:0.99, green:0.80, blue:0.89, alpha:1.0).CGColor
        backgroundGradient.colors = [colorTop, colorBottom]
        backgroundGradient.locations = [0.0, 1.0]
        backgroundGradient.frame = view.frame
        view.layer.insertSublayer(backgroundGradient, atIndex: 0)
    }
}
