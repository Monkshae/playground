//
//  ViewController.swift
//  InterViewDemo
//
//  Created by licong on 2017/3/18.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

//由于 Swift 支持全局函数，全局函数可以在当前所在的命名空间下随意调用。所以我们只需要定义一个全局函数即可
func HGLog<T>(_ message:T, file:String = #file, function:String = #function,
           line:Int = #line) {
    #if DEBUG
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        //打印日志内容
        print("\(fileName):\(line) \(function) | \(message)")
    #endif
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        HGLog("哈哈")
        // Do any additional setup after loading the view, typically from a nib.
    }


   

}

