//
//  SingleViewController.swift
//  YHANBL
//
//  Created by Benjamin Chareyron on 11/06/2016.
//  Copyright © 2016 Benjamin Chareyron. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController {

    @IBOutlet weak var letterPhoto: UIImageView?
    @IBOutlet weak var letterTitle: UILabel?
    @IBOutlet weak var letterContent: UITextView?
    @IBAction func back(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBOutlet var cardView: UIView!
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var front: UIView!
    
    var letter: Letter! = nil
    
    var fromOneToTwo : Bool = true
    var view1 : UIImageView!
    var view2 : UIView!
    var container : UIView!
    
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
    
        //construct imageView
        view1 = UIImageView(frame: CGRectMake(0, 0, cardView.bounds.size.width, cardView.bounds.size.height))
        view1.image = letter.photo
        view1.contentMode = UIViewContentMode.ScaleAspectFill
        view1.clipsToBounds = true
        view1.layer.cornerRadius = 5
        
        //construct contentView
        view2 = UIView(frame: CGRect(x: 0,y: 0, width: cardView.bounds.size.width, height: cardView.bounds.size.height))
        view2.layer.cornerRadius = 5
        
        view2.backgroundColor = UIColor.whiteColor()
        let letterTitle = UILabel(frame: CGRectMake(30,20, 200, 40))
        letterTitle.text = letter.title
        letterTitle.font = UIFont(name: "Montserrat-Regular", size: 17)
        letterTitle.textColor = hexStringToUIColor("7F8080")
        
        let letterContent = UITextView(frame: CGRectMake(30, 80, 220, 345))
        letterContent.showsVerticalScrollIndicator = false
        letterContent.text = letter.content
        letterContent.font = UIFont(name: "Montserrat-Light", size: 14)
        letterContent.textColor = hexStringToUIColor("7F8080")
        
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
        
        self.letterPhoto?.image = letter.photo
    }
    
    
}
