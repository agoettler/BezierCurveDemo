//
//  ControlPointView.swift
//  BezierCurveDemo
//
//  Created by Andrew Goettler on 9/18/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class ControlPointView: UIView {

    func setup()
    {
        // it appears that the size of the view can be set by the caller
        
        // create and bind the gesture recognizer programmatically
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.translateOnPan))
        
        // add the new gesture recognizer to the
        self.gestureRecognizers = [panGestureRecognizer]
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        setup()
    }
    
    // this is strange - functions can be optional!
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func draw(_ rect: CGRect)
    {
        // Drawing code
        UIColor.blue.setStroke()
        UIColor.blue.setFill()
        let controlPointCircle: UIBezierPath = UIBezierPath(ovalIn: rect)
        controlPointCircle.lineWidth = 2
        controlPointCircle.addClip()
        controlPointCircle.fill()
        //controlPointCircle.stroke()
    }
    
    func translateOnPan(recognizer: UIPanGestureRecognizer)
    {
        let translation = recognizer.translation(in: self)
        
        // since each ControPointView has its own method for panning, no need to generalize like in the viewController
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self)
    }

}
