//
//  TableViewCell.swift
//  YHANBL
//
//  Created by Benjamin Chareyron on 11/06/2016.
//  Copyright © 2016 Benjamin Chareyron. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var user:[Letter] = []
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("videoCell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.title.text = user[indexPath.row].title
        cell.photo.image = user[indexPath.row].photo
        cell.content.text = user[indexPath.row].content
        
        cell.letter = user[indexPath.row]
        
        return cell
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let singleViewController = segue.destinationViewController as! SingleViewController
//        
//        if let selectedLetterCell = sender as? CollectionViewCell{
//            let indexPath = tableView.indexPathForCell(selectedLetterCell)
//        }
//        
//    }
}

extension TableViewCell : UICollectionViewDataSource {

    

}

extension TableViewCell : UICollectionViewDelegateFlowLayout {
    
}


