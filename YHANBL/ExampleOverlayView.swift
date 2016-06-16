//
//  ExampleOverlayView.swift
//  KolodaView
//
//

import UIKit
import Koloda

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class ExampleOverlayView: OverlayView {
    
//    @IBOutlet weak var overlayImageView: UIImageView! = {
//        
//        var imageView = UIImageView(frame: self.bounds)
//        self.addSubview(imageView)
//        
//        return imageView
//    }()

    @IBOutlet weak var overlayImageView: UIImageView!
    
    var imageView = UIImage()
    
    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .Left? :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .Right? :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }
    
}
