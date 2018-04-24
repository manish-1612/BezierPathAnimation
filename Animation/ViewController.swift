//
//  ViewController.swift
//  Animation
//
//  Created by Manish Kumar on 23/04/18.
//  Copyright © 2018 Innofied. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewToAnimate : UIView?
    var circleLayer : CAShapeLayer?
    var heightOfOriginalView: CGFloat = 150.0
    var heightOfAnimatedView: CGFloat = 63.0
    var widthOfView : CGFloat = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        createARectangleView(withWidth: widthOfView, withHeight: heightOfOriginalView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func createARectangleView(withWidth width: CGFloat, withHeight height: CGFloat){
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: height))
        bezierPath.addLine(to: CGPoint(x: (width * 1/5) - 10.0, y: height))
        bezierPath.addQuadCurve(to: CGPoint(x:(width * 1/5) + 10.0 , y: height + 10.0), controlPoint: CGPoint(x:(width * 1/5) + 2.0 , y: height - 2.0 ))
        bezierPath.addQuadCurve(to: CGPoint(x:(width * 4/5) - 10.0 , y: height + 10.0), controlPoint: CGPoint(x:(width / 2.0) , y: height + 125.0 ))
        bezierPath.addQuadCurve(to: CGPoint(x:(width * 4/5) + 10.0 , y: height ), controlPoint: CGPoint(x:(width * 4/5) - 2.0 , y: height - 2.0 ))
        bezierPath.addLine(to: CGPoint(x: width, y: height))
        bezierPath.addLine(to: CGPoint(x: width, y: 0.0))
        bezierPath.addLine(to: CGPoint(x: 0.0, y: 0.0))
        bezierPath.addLine(to: CGPoint(x: 0.0, y: height))
        bezierPath.close()
        
        circleLayer = CAShapeLayer()
        circleLayer?.path = bezierPath.cgPath
        circleLayer?.fillColor = UIColor.green.cgColor
        
        viewToAnimate = UIView()
        viewToAnimate?.layer.addSublayer(circleLayer!)
        self.view.addSubview(viewToAnimate!)

        
    }
    
    

    

    @IBAction func animate(_ sender: UIButton) {
        animateMaskViewToRectangle(withParentViewWidth: widthOfView, parentViewHeight: heightOfAnimatedView)
    }
    
    
    @IBAction func resetAnimationLayer(_ sender: Any) {
        
        if circleLayer != nil{
            circleLayer?.removeFromSuperlayer()
            circleLayer = nil
        }
        
        if viewToAnimate != nil{
            viewToAnimate?.removeFromSuperview()
            viewToAnimate = nil
        }
        
        createARectangleView(withWidth: widthOfView, withHeight: heightOfOriginalView)

    }
    

    func animateMaskViewToRectangle(withParentViewWidth width: CGFloat, parentViewHeight height: CGFloat){
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: height))
        bezierPath.addLine(to: CGPoint(x: (width * 1/5) - 10.0, y: height))
        bezierPath.addLine(to: CGPoint(x:(width * 1/5) + 10.0 , y: height))
        bezierPath.addLine(to: CGPoint(x:(width * 4/5) - 10.0 , y: height))
        bezierPath.addLine(to: CGPoint(x:(width * 4/5) + 10.0 , y: height ))
        bezierPath.addLine(to: CGPoint(x: width, y: height))
        bezierPath.addLine(to: CGPoint(x: width, y: 0.0))
        bezierPath.addLine(to: CGPoint(x: 0.0, y: 0.0))
        bezierPath.addLine(to: CGPoint(x: 0.0, y: height))
        bezierPath.close()

        circleLayer?.path = bezierPath.cgPath
    

        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.25
        animation.toValue = bezierPath
        circleLayer?.add(animation, forKey: nil)
    }
    
}

