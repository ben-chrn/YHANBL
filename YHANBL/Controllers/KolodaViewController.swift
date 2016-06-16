//
//  KolodaViewController.swift
//  YHANBL
//
//  Created by Benjamin Chareyron on 12/06/2016.
//  Copyright © 2016 Benjamin Chareyron. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: UInt = 5

var toStoreLetters = [Letter]()

class KolodaViewController: UIViewController {

//    @IBOutlet weak var kolodaView = KolodaView!
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
    var validatedLetters: [Letter] = []
    var deletedLetters: [Letter] = []
    
    @IBAction func toInbox(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion:nil)
    }
    
    private var dataSource: Array<Letter> = {
        let photo1 = UIImage(named: "landscape1")
        let letter1 = Letter(user: "John", photo: photo1, title: "A letter", content: "This is a beautiful letter")!
        
        let photo2 = UIImage(named: "landscape2")
        let letter2 = Letter(user: "Marie", photo: photo2, title: "A letter 2", content: "This is a beautiful letter")!
        
        let photo3 = UIImage(named: "landscape3")
        let letter3 = Letter(user: "Marie", photo: photo3, title: "A letter 3", content: "This is a beautiful letter")!
        
        let photo4 = UIImage(named: "landscape4")
        let letter4 = Letter(user: "John", photo: photo4, title: "A letter 4", content: "This is a beautiful letter")!
        
        let photo5 = UIImage(named: "landscape5")
        let letter5 = Letter(user: "John", photo: photo5, title: "A letter 5", content: "This is a beautiful letter")!
        
        var letters = [Letter]()
            
        letters += [letter1, letter2, letter3, letter4, letter5]
        
        return letters
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        kolodaView.layer.shadowColor = UIColor.blackColor().CGColor
        kolodaView.layer.shadowOffset = CGSizeMake(5, 5)
        kolodaView.layer.shadowRadius = 5
        
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        //Si il n'y a pas de nouvelles lettres
        if(dataSource.count == 0){
            print("je suis vide")
            kolodaView.alpha = 0
            buttonsView.alpha = 0
            emptyView.alpha = 1
        }
        else{
            emptyView.alpha = 0
            kolodaView.alpha = 1
            buttonsView.alpha = 1
        }

        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.barTintColor = hexStringToUIColor("FF9266")
        nav?.tintColor = hexStringToUIColor("FFFFFF")
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 68, height: 22))
        imageView.contentMode = .ScaleAspectFit
        // 4
        let image = UIImage(named: "logo")
        imageView.image = image
        // 5
        navigationItem.titleView = imageView

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        
        //WHY DOES LABEL FADEOUT
        if(dataSource.count == 0){
            print("je suis vide")
            emptyView.alpha = 1
            kolodaView.alpha = 0
            buttonsView.alpha = 0
            
        }
        else{
            emptyView.alpha = 0
            kolodaView.alpha = 1
            buttonsView.alpha = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Navigation
    @IBAction func unwindToCards(sender: UIStoryboardSegue){
        if sender.sourceViewController is TableViewController{
            print("coming from table")
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cardValidated(sender: UIButton) {
        kolodaView.swipe(SwipeResultDirection.Right)
    }
    
    @IBAction func cardDeleted(sender: UIButton) {
        kolodaView.swipe(SwipeResultDirection.Left)
    }
    
    @IBAction func cardRevert(sender: UIButton) {
        kolodaView.revertAction()
    }

}

//MARK: KolodaViewDelegate
extension KolodaViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        dataSource = []
        performSegueWithIdentifier("toInbox", sender: self)
    }
    
    func koloda(koloda: KolodaView, didSwipeCardAtIndex index: UInt, inDirection direction: SwipeResultDirection){
        let letter = dataSource[Int(index)]
        print(letter.title)
        if(direction == SwipeResultDirection.Right){
            validatedLetters+=[letter]
            toStoreLetters+=[letter]
        }
        else{
            deletedLetters+=[letter]
        }
            
    }

}

//MARK: KolodaViewDataSource
extension KolodaViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return UInt(dataSource.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        
        let view = NSBundle.mainBundle().loadNibNamed("CustomKolodaView",
                                                      owner: self, options: nil)[0] as? CustomKolodaView
        
        
        view!.letterImage.image = dataSource[Int(index)].photo
        view!.letterTitle.text = dataSource[Int(index)].title
        view!.letterContent.text = dataSource[Int(index)].content
        
        return view!
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("CustomOverlayView",
                                                  owner: self, options: nil)[0] as? CustomOverlayView
    }
}

extension UIViewController{
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
