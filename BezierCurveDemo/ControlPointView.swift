//
//  ControlPointView.swift
//  BezierCurveDemo
//
//  Created by Andrew Goettler on 9/18/16.
//  Copyright © 2016 Andrew Goettler. All rights reserved.
//

import UIKit

class ControlPointView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.white.setStroke()
        UIColor.blue.setFill()
        let controlPointCircle: UIBezierPath = UIBezierPath(ovalIn: rect)
        controlPointCircle.addClip()
        controlPointCircle.fill()
        controlPointCircle.stroke()
    }

}
