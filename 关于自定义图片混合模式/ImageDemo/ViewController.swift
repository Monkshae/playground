//
//  ViewController.swifthttp://www.jianshu.com/p/fee50e03f7b5
//  ImageDemo
//
//  Created by licong on 2017/3/12.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

/*
  ojec中国介绍图像学https://www.objccn.io/issue-3-1/
 
  https://www.raywenderlich.com/69855/image-processing-in-ios-part-1-raw-bitmap-modification
  中文翻译 http://www.tairan.com/archives/7427/
  https://www.raywenderlich.com/71151/image-processing-ios-part-2-core-graphics-core-image-gpuimage
  https://www.raywenderlich.com/32283/core-graphics-tutorial-lines-rectangles-and-gradients
  http://blog.csdn.net/zhangao0086/article/details/39120331
  http://www.jianshu.com/p/3e2cca585ccc
  http://www.cocoachina.com/industry/20140115/7703.html
  http://www.jianshu.com/p/175631f45ec6
 
 */


private var kRadio = CGFloat(1.0)

class ViewController: UIViewController {

    private var imageView: UIImageView!
    private var a: Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       setupImages()
        
    }

    
    func setupImages()  {
        
        let screenWidth = UIScreen.main.bounds.width //375
        let inputBackgroundImage = UIImage(named: "demo1.jpg")
        let radio = inputBackgroundImage!.size.width / inputBackgroundImage!.size.height
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: CGFloat(screenWidth / radio)))
        view.addSubview(imageView)
        imageView.image = inputBackgroundImage
        
        let inputImage = UIImage(named: "ghost")
        let newInputImage  = createInputImage(inputImage: inputImage!)
        imageView.image = newInputImage
    }
    
    
    func createInputImage(inputImage:UIImage) -> UIImage {

        let inputBackgroundImage = UIImage(named: "demo1.jpg")
        let contextSize = inputBackgroundImage!.size
        let contextRect = CGRect(x: 0, y: 0, width: contextSize.width, height: contextSize.height)
        
        
        let inputRect = CGRect(x: 0, y: 0, width: inputImage.size.width, height: inputImage.size.height)

        UIGraphicsBeginImageContext(contextSize)
        let context = UIGraphicsGetCurrentContext()
        context!.clear(contextRect)

        //看看画布在哪里？
        context?.addRect(contextRect)
        context?.setFillColor(UIColor.green.cgColor)
        context?.fillPath()
        
        let flip = CGAffineTransform(scaleX: 1.0, y: -1.0)
        let flipThenShift = flip.translatedBy(x: 0, y: -contextRect.height)
        context!.concatenate(flipThenShift)
        let transformedInputRect = inputRect.applying(flipThenShift)
        context?.draw(inputImage.cgImage!, in: transformedInputRect)
        let  newInputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let  outputImage = filerImage(inputImage: newInputImage!, inputBackgroundImage: inputBackgroundImage!)

        
        return outputImage
    }
    
    func filerImage(inputImage: UIImage, inputBackgroundImage: UIImage) -> UIImage
    {
        let filter = CIFilter(name: "CISubtractBlendMode")
        filter?.setValue(CIImage(image: inputImage), forKey: kCIInputImageKey)
        filter?.setValue(CIImage(image: inputBackgroundImage), forKey: kCIInputBackgroundImageKey)
        let outputCIImage = filter?.outputImage
        
        
        let context = CIContext(options: nil)
        let  outputCGImage = context.createCGImage(outputCIImage!, from: (outputCIImage!.extent))
        let outputImage = UIImage(cgImage:  outputCGImage!, scale: inputBackgroundImage.scale, orientation: inputBackgroundImage.imageOrientation)
        return outputImage
//        imageView.image = outputImage
    }
 


}

