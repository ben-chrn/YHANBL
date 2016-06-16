//
//  LetterCell.swift
//  YHANBL
//
//  Created by Benjamin Chareyron on 11/06/2016.
//  Copyright © 2016 Benjamin Chareyron. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var letter: Letter? = nil
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UITextView!

}
