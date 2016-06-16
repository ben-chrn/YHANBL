//
//  WriteViewController.swift
//  YHANBL
//
//  Created by Benjamin Chareyron on 13/06/2016.
//  Copyright © 2016 Benjamin Chareyron. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func send(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    
    //VIew content
    @IBOutlet var cardView: UIView!

    var fromOneToTwo : Bool = true
    var view1 : UIImageView!
    var view2 : UIView!
    var container : UIView!
    
    var letterTitle : UITextField!
    var letterContent : UITextField!
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        let v1 = (fromOneToTwo ? self.view1 : self.view2)
        let v2 = (fromOneToTwo ? self.view2 : self.view1)
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right:
                UIView.transitionFromView(v1, toView: v2, duration: 0.5, options: .TransitionFlipFromLeft) { finished in
                    
                    self.fromOneToTwo = !self.fromOneToTwo
                    print("2/fromOneToTwo \(self.fromOneToTwo) ")
                }
                
            case UISwipeGestureRecognizerDirection.Left:
                UIView.transitionFromView(v1, toView: v2, duration: 0.5, options: .TransitionFlipFromRight) { finished in
                    
                    self.fromOneToTwo = !self.fromOneToTwo
                    print("2/fromOneToTwo \(self.fromOneToTwo) ")
                }
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        //construct imageView
        view1 = UIImageView(frame: CGRectMake(0, 0, cardView.bounds.size.width, cardView.bounds.size.height))
        view1.image = UIImage(named: "defaultPicture")
        view1.contentMode = UIViewContentMode.ScaleAspectFill
        view1.clipsToBounds = true
        view1.layer.cornerRadius = 5
        let tapGesture = UITapGestureRecognizer(target: view1, action: #selector(WriteViewController.respondToSwipeGesture(_:)))
        self.cardView.addGestureRecognizer(tapGesture)
        
        //construct contentView
        view2 = UIView(frame: CGRect(x: 0,y: 0, width: cardView.bounds.size.width, height: cardView.bounds.size.height))
        view2.layer.cornerRadius = 5
        
        view2.backgroundColor = UIColor.whiteColor()
        
        letterTitle = UITextField(frame: CGRectMake(30,20, 200, 40))
        letterTitle.text = "Name"
        letterTitle.font = UIFont(name: "Montserrat-Regular", size: 17)
        letterTitle.textColor = hexStringToUIColor("7F8080")
        letterTitle.userInteractionEnabled = true
        letterTitle.returnKeyType = UIReturnKeyType.Done
        
        self.letterTitle.delegate = self
        
        
        letterContent = UITextField(frame: CGRectMake(30, 80, 220, 345))
        letterContent.text = "Content"
        letterContent.font = UIFont(name: "Montserrat-Light", size: 14)
        letterContent.textColor = hexStringToUIColor("7F8080")
        letterContent.returnKeyType = UIReturnKeyType.Done
        letterContent.contentVerticalAlignment = UIControlContentVerticalAlignment.Top;

        
        self.letterContent.delegate = self
        
        view2.addSubview(letterTitle)
        view2.addSubview(letterContent)
        
        cardView.addSubview(view2)
        cardView.addSubview(view1)
        cardView.layer.cornerRadius = 5
        
        self.view.addSubview(cardView)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(SingleViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.cardView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(SingleViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.cardView.addGestureRecognizer(swipeLeft)
        
        sendButton.enabled = false
        

        
    }
    
    //MARK: Textfield management
    
    @IBAction func textFieldDidEndEditing(sender: UITextField) {
//        navigationItem.title = textField.text
        print("Finished button")
        
        if letterTitle.text == ""{
            letterTitle.text = "Name"
        }
        else if letterContent.text == ""{
            letterContent.text = "Write a beautiful letter"
        }
        
        checkValidContent(sender)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        sendButton.enabled = false
        if letterTitle.isFirstResponder(){
            letterTitle.text = nil
        }
        else{
            letterContent.text = nil
        }
    }
    
    func checkValidContent(textField: UITextField){
        print("checking content")
        print(textField.text)
        sendButton.enabled = !textField.text!.isEmpty
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sendButton === sender{
            let title = letterTitle.text ?? ""
//            let photo = imageView.image
            let content = letterContent.text
            
            let letter = Letter(user: "", photo: nil, title: title, content: content!)
            
            print(letter!.title, letter?.content)
            
            //CHECK LETTER + PUSH LETTER INTO DB
        }
    }
    
    
    //MARK: Picture management
    func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        //Hide the keyboard
        letterTitle.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        
        //Allow pgotos to be picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    //cancel image picker
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //dismiss picker if user cancelled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //constant picked image
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //define picture as selected
        view1.image = selectedImage
        
        //dismiss picker
        dismissViewControllerAnimated(true, completion: nil)
        
    }


}
