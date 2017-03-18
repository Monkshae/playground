//
//  ViewController.swift
//  DispatchDemo
//
//  Created by licong on 2017/3/13.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

//https://www.raywenderlich.com/148515/grand-central-dispatch-tutorial-swift-3-part-2
//https://www.raywenderlich.com/148513/grand-central-dispatch-tutorial-swift-3-part-1


let queue = DispatchQueue.global(qos: .default)

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //当并行执行的任务更新数据时，会产生数据不一样的情况
        for i in 1...10 {
            queue.async {
                print("\(i)")
            }
        }
        
        //使用信号量保证正确性
        //创建一个初始计数值为1的信号
        let semaphore = DispatchSemaphore(value: 1)
        for i in 1...10 {
            queue.async {
                //如果信号总量为0，进入等待状态，信号量大于0时，继续执行代码，同时将信号总量 -1
                semaphore.wait()
                print("\(i)")
                //发信号，使原来的信号计数值+1
                semaphore.signal()
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

