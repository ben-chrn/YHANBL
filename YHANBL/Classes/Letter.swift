//
//  Letter.swift
//  YHANBL
//
//  Created by Benjamin Chareyron on 11/06/2016.
//  Copyright © 2016 Benjamin Chareyron. All rights reserved.
//

import Foundation
import UIKit

class Letter {
    
    var user:String
    var photo: UIImage?
    var title: String?
    var content: String
    
    init?(user:String, photo:UIImage?, title:String?, content:String){
        self.user = user
        self.photo = photo
        self.title = title
        self.content = content
    }
    
}