//
//  GradationView.swift
//  DesignableGradationView
//
//  Created by takeru on 2018/10/02.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

@IBDesignable class GradationView: UIView {

    @IBInspectable var startColor: UIColor = .white
    @IBInspectable var endColor: UIColor = .black

    @IBInspectable var xPosition: CGFloat = 0.5
    @IBInspectable var yPosition: CGFloat = 0.5
    @IBInspectable var circleSize: CGFloat = 1.0

    override func draw(_ rect: CGRect) {

        var startRed: CGFloat = 0
        var startGreen: CGFloat = 0
        var startBlue: CGFloat = 0
        var startAlpha: CGFloat = 0
        self.startColor.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)

        var endRed: CGFloat = 0
        var endGreen: CGFloat = 0
        var endBlue: CGFloat = 0
        var endAlpha: CGFloat = 0
        self.endColor.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)

        let context = UIGraphicsGetCurrentContext()
        context!.saveGState()
        context?.addEllipse(in: self.frame)

        let colorSpaceRef:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [
            startRed, startGreen, startBlue, startAlpha,
            endRed, endGreen, endBlue, endAlpha,
        ]

        let locations: [CGFloat] = [ 0.0, 1.0 ]
        let locationCount = UInt(locations.count)
        let gradientRef: CGGradient = CGGradient(colorSpace: colorSpaceRef, colorComponents: components, locations: locations, count: Int(locationCount))!

        let frame: CGRect = self.bounds
        var startCenter: CGPoint = frame.origin
        startCenter.x += frame.size.width  * self.xPosition * 0.1
        startCenter.y += frame.size.height * self.yPosition * 0.1

        let endCenter = startCenter

        let startRadius: CGFloat = 0.0
        let endRadius: CGFloat = self.bounds.width * self.circleSize * 0.1

        context!.drawRadialGradient(
            gradientRef,
            startCenter: startCenter,
            startRadius: startRadius,
            endCenter: endCenter,
            endRadius: endRadius,
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        )
        context!.restoreGState()
    }
}
