//
//  ViewController.swift
//  SwapDemo
//
//  Created by licong on 2017/3/8.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var a = [1]
        swap(num: &a, a: 0, b: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func swap(num: inout [Int], a: Int, b: Int){
        guard num.count > 0 else {
            return
        }
        assert((a >= 0 && a < num.count), "数组的index必须大于等于0且不能越界")
        assert((b >= 0 && b < num.count), "数组的index必须大于等于0且不能越界")
        let tmp  = num[a]
        num[a] = num[b]
        num[b] = tmp
    }
}

