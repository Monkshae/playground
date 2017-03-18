//
//  ViewController.swift
//  DrawLine
//
//  Created by licong on 2017/3/16.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setupLine() {
        let color = UIColor.red
        color.set()
        let path = UIBezierPath()
        path.lineWidth = 5
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.move(to: CGPoint(x: 100 + 10, y: 40 + 10))
        path.addLine(to: CGPoint(x: 160 + 10, y: 140 + 10))
        path.addLine(to: CGPoint(x: 40 + 10, y: 140 + 10))
        path.addLine(to: CGPoint(x: 10, y: 40 + 10))
        path.close()
        
        let layer = CAShapeLayer.init()
        layer.path = path.cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        layer.strokeColor = UIColor.red.cgColor
        layer.lineWidth = path.lineWidth
        
        view.layer .addSublayer(layer)
        
        
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.8
        layer.add(animation, forKey: "")
    }
}

