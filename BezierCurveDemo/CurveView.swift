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
    
    var currentCurveMode: BezierCurveMode = BezierCurveMode.quadratic
    
    var controlPoints = [ControlPointView]()
    
    let controlPointSize: CGSize = CGSize(width: 20, height: 20)
    
    enum BezierCurveMode: Int
    {
        case quadratic = 3, cubic = 4
    }
    
    func setup()
    {
        self.currentCurveMode = BezierCurveMode.quadratic
        
        self.createControlPoints()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.setup()
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
 
    // if the corner points are not necessary, this function may be removed
    func setGeometry()
    {
        topLeftCorner = bounds.origin
        topRightCorner = CGPoint(x: bounds.origin.x + bounds.width, y: bounds.origin.y)
        bottomRightCorner = CGPoint(x: bounds.origin.x + bounds.width, y: bounds.origin.y + bounds.height)
        bottomLeftCorner = CGPoint(x: bounds.origin.x, y: bounds.origin.y + bounds.height)
    }
    
    func createControlPoints()
    {
        for index in 0..<currentCurveMode.rawValue
        {
            controlPoints.append(ControlPointView(frame: CGRect(origin: CGPoint(x: 250, y: 250 * index), size: controlPointSize)))
            
            self.addSubview(controlPoints[index])
        }
    }
}
