//
//  CurveView.swift
//  BezierCurveDemo
//
//  Created by Andrew Goettler on 9/18/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class CurveView: UIView
{
    // these may not be necessary
    var topLeftCorner: CGPoint?
    var topRightCorner: CGPoint?
    var bottomRightCorner: CGPoint?
    var bottomLeftCorner: CGPoint?
    
    // if the corner points are not necessary, this function may be removed
    func setGeometry()
    {
        topLeftCorner = bounds.origin
        topRightCorner = CGPoint(x: bounds.origin.x + bounds.width, y: bounds.origin.y)
        bottomRightCorner = CGPoint(x: bounds.origin.x + bounds.width, y: bounds.origin.y + bounds.height)
        bottomLeftCorner = CGPoint(x: bounds.origin.x, y: bounds.origin.y + bounds.height)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func draw(_ rect: CGRect)
    {
        // Drawing code
        
        self.setGeometry()
        
        let viewBoundary: UIBezierPath = UIBezierPath(rect: bounds)
        viewBoundary.lineWidth = 2
        viewBoundary.lineCapStyle = CGLineCap.round
        UIColor.black.setStroke()
        viewBoundary.stroke()
    }
 

}
