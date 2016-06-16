//
//  TableViewController.swift
//  YHANBL
//
//  Created by Benjamin Chareyron on 11/06/2016.
//  Copyright © 2016 Benjamin Chareyron. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var oldLetters = [Letter]()
    var lettersFinal = [[Letter]]()
    var lettersToSortByUsers = [Letter]()


    func loadSampleLetters(){
        let photo1 = UIImage(named: "landscape1")
        let letter6 = Letter(user: "Lucas", photo: photo1, title: "A letter6", content: "This is a beautiful letter")!
        
        let photo2 = UIImage(named: "landscape2")
        let letter7 = Letter(user: "Lucas", photo: photo2, title: "A letter 7", content: "This is a beautiful letter")!
        
        let photo3 = UIImage(named: "landscape3")
        let letter8 = Letter(user: "Marie", photo: photo3, title: "A letter 8", content: "This is a beautiful letter")!
        
        let photo4 = UIImage(named: "landscape4")
        let letter9 = Letter(user: "John", photo: photo4, title: "A letter 9", content: "This is a beautiful letter")!
        
        let photo5 = UIImage(named: "landscape5")
        let letter10 = Letter(user: "John", photo: photo5, title: "A letter 10", content: "This is a beautiful letter")!
        
        oldLetters += [letter6, letter7, letter8, letter9, letter10]
        
        lettersToSortByUsers = oldLetters + toStoreLetters
    }
    
    func sortLettersByUsers(){
        
        print(lettersToSortByUsers)
        
        let letterArray = lettersToSortByUsers
        
        var userArray = [String]()
        
        for letter in letterArray{
            if (userArray.indexOf(letter.user) != nil){
                
            }
            else{
                userArray += [letter.user]
            }
        }
        
//        for user in userArray{
//            for letter in lettersToSortByUsers{
//                if(user == letter.user){
//                    if let index = lettersFinal[letter].indexOf(user){
//                        lettersFinal[index] += letter
//                    }
//                    else{
//                        lettersFinal += [[letter]]
//                    }
//                }
//            }
//        }
        
        var userTable = [Letter]()
        
        for user in userArray{
            for letter in lettersToSortByUsers{
                if user == letter.user{
                    print(letter.user)
                    userTable+=[letter]
                }
            }
            lettersFinal+=[userTable]
            print(lettersFinal)
            userTable = []
        }
        
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleLetters()
        sortLettersByUsers()
        
    
        //Navbar styling
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
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return lettersFinal.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.user = lettersFinal[indexPath.section]
        
        return cell
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let letterCell = sender as? CollectionViewCell, let letterDetail = segue.destinationViewController as? SingleViewController{
            let letter = letterCell.letter
            letterDetail.letter = letter
        }
    }
    
    @IBAction func unwindToInbox(sender: UIStoryboardSegue){
        if sender.sourceViewController is WriteViewController{
            print("coming from write")
            
        }
        
        else if sender.sourceViewController is SingleViewController{
            print("coming from single")
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}