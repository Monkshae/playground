//
//  ImageProcessor.m
//  SpookCam
//
//  Created by Jack Wu on 2/21/2014.
//
//

#import "ImageProcessor.h"
#import <CoreImage/CoreImage.h>

@interface ImageProcessor ()

@end

@implementation ImageProcessor

+ (instancetype)sharedProcessor {
  static id sharedInstance = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  
  return sharedInstance;
}

#pragma mark - Public

- (void)processImage:(UIImage*)inputImage {
  UIImage * outputImage = [self processUsingPixels:inputImage];
  
  if ([self.delegate respondsToSelector:
       @selector(imageProcessorFinishedProcessingWithImage:)]) {
    [self.delegate imageProcessorFinishedProcessingWithImage:outputImage];
  }
}

#pragma mark - Private

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )
- (UIImage *)processUsingPixels:(UIImage*)inputImage {
  
  // 1. Get the raw pixels of the image
//  UInt32 * inputPixels;
//  
//  CGImageRef inputCGImage = [inputImage CGImage];
//  NSUInteger inputWidth = CGImageGetWidth(inputCGImage);
//  NSUInteger inputHeight = CGImageGetHeight(inputCGImage);
//  
//  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//  
//  NSUInteger bytesPerPixel = 4;
//  NSUInteger bitsPerComponent = 8;
//  
//  NSUInteger inputBytesPerRow = bytesPerPixel * inputWidth;
//  
//  inputPixels = (UInt32 *)calloc(inputHeight * inputWidth, sizeof(UInt32));
//  
//  CGContextRef context = CGBitmapContextCreate(inputPixels, inputWidth, inputHeight,
//                                               bitsPerComponent, inputBytesPerRow, colorSpace,
//                                               kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//  
//  CGContextDrawImage(context, CGRectMake(0, 0, inputWidth, inputHeight), inputCGImage);
//  
// 
////  return inputImage;
//    
//    UIImage * ghostImage = [UIImage imageNamed:@"ghost"];
//    CGImageRef ghostCGImage = [ghostImage CGImage];
//    CGFloat ghostImageAspectRatio = ghostImage.size.width / ghostImage.size.height;
//    NSInteger targetGhostWidth = inputWidth * 0.25;
//    CGSize ghostSize = CGSizeMake(targetGhostWidth, targetGhostWidth / ghostImageAspectRatio);
//    CGPoint ghostOrigin = CGPointMake(inputWidth * 0.5, inputHeight * 0.2);
//    NSUInteger ghostBytesPerRow = bytesPerPixel * ghostSize.width;
//    UInt32 * ghostPixels = (UInt32 *)calloc(ghostSize.width * ghostSize.height, sizeof(UInt32));
//    
//    CGContextRef ghostContext = CGBitmapContextCreate(ghostPixels, ghostSize.width, ghostSize.height,
//                                                      bitsPerComponent, ghostBytesPerRow, colorSpace,
//                                                      kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//    CGContextDrawImage(ghostContext, CGRectMake(0, 0, ghostSize.width, ghostSize.height),ghostCGImage);
//    
//    
//    //offsetPixelCountForInput小鬼图片的第一个像素点的位置
//    NSUInteger offsetPixelCountForInput = ghostOrigin.y * inputWidth + ghostOrigin.x;
//    for (NSUInteger j = 0; j < ghostSize.height; j++) {
//        for (NSUInteger i = 0; i < ghostSize.width; i++) {
//            UInt32 * inputPixel = inputPixels + j * inputWidth + i + offsetPixelCountForInput;
//            UInt32 inputColor = *inputPixel;
//            
//            UInt32 * ghostPixel = ghostPixels + j * (int)ghostSize.width + i;
//            UInt32 ghostColor = *ghostPixel;
//            
//            // Blend the ghost with 50% alpha
//            CGFloat ghostAlpha = 0.5f * (A(ghostColor) / 255.0);
//            UInt32 newR = R(inputColor) * (1 - ghostAlpha) + R(ghostColor) * ghostAlpha;
//            UInt32 newG = G(inputColor) * (1 - ghostAlpha) + G(ghostColor) * ghostAlpha;
//            UInt32 newB = B(inputColor) * (1 - ghostAlpha) + B(ghostColor) * ghostAlpha;
//            
//            // Clamp, not really useful here :p
//            newR = MAX(0,MIN(255, newR));
//            newG = MAX(0,MIN(255, newG));
//            newB = MAX(0,MIN(255, newB));
//            *inputPixel = RGBAMake(newR, newG, newB, A(inputColor));
//        }
//    }
//    
//   
//    
//    // Convert the image to black and white
//    for (NSUInteger j = 0; j < inputHeight; j++) {
//        for (NSUInteger i = 0; i < inputWidth; i++) {
//            UInt32 * currentPixel = inputPixels + (j * inputWidth) + i;
//            UInt32 color = *currentPixel;
//            
//            // Average of RGB = greyscale
//            UInt32 averageColor = (R(color) + G(color) + B(color)) / 3.0;
//            
//            *currentPixel = RGBAMake(averageColor, averageColor, averageColor, A(color));
//        }
//    }
//    
//
//    // Create a new UIImage
//    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
//    UIImage * processedImage = [UIImage imageWithCGImage:newCGImage];
//    
//    
//    // Cleanup!
//    CGColorSpaceRelease(colorSpace);
//    CGContextRelease(context);
//    CGContextRelease(ghostContext);
//    free(inputPixels);
//    free(ghostPixels);
//    
//    return processedImage;
    UIImage * outputImage = [self processSubtractUsingCoreImage:inputImage];

    return outputImage;
}



- (UIImage *)processUsingCoreGraphics:(UIImage*)input {
    CGRect imageRect = {CGPointZero,input.size};
    NSInteger inputWidth = CGRectGetWidth(imageRect);
    NSInteger inputHeight = CGRectGetHeight(imageRect);
    
    // 1) Calculate the location of Ghosty
    UIImage * ghostImage = [UIImage imageNamed:@"ghost.png"];
    CGFloat ghostImageAspectRatio = ghostImage.size.width / ghostImage.size.height;
    
    NSInteger targetGhostWidth = inputWidth * 0.25;
    CGSize ghostSize = CGSizeMake(targetGhostWidth, targetGhostWidth / ghostImageAspectRatio);
    CGPoint ghostOrigin = CGPointMake(inputWidth * 0.5, inputHeight * 0.2);
    
    CGRect ghostRect = {ghostOrigin, ghostSize};
    
    // 2) Draw your image into the context.
    UIGraphicsBeginImageContext(input.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGAffineTransform flip = CGAffineTransformMakeScale(1.0, -1.0);
    CGAffineTransform flipThenShift = CGAffineTransformTranslate(flip,0,-inputHeight);
    CGContextConcatCTM(context, flipThenShift);
    
    CGContextDrawImage(context, imageRect, [input CGImage]);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    CGContextSetAlpha(context,0.5);
    CGRect transformedGhostRect = CGRectApplyAffineTransform(ghostRect, flipThenShift);
    CGContextDrawImage(context, transformedGhostRect, [ghostImage CGImage]);
    
    // 3) Retrieve your processed image
    UIImage * imageWithGhost = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 4) Draw your image into a grayscale context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    context = CGBitmapContextCreate(nil, inputWidth, inputHeight,
                                    8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    
    CGContextDrawImage(context, imageRect, [imageWithGhost CGImage]);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage * finalImage = [UIImage imageWithCGImage:imageRef];
    
    // 5) Cleanup
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    return finalImage;
}


- (UIImage *)processUsingCoreImage:(UIImage*)input {
    
    CIImage * inputCIImage = [[CIImage alloc] initWithImage:input];
    
    
    // 1. Create a grayscale filter
    CIFilter * grayFilter = [CIFilter filterWithName:@"CIColorControls"];
    [grayFilter setValue:@(0) forKeyPath:@"inputSaturation"];
    
    // 2. Create your ghost filter
    
    // Use Core Graphics for this
    UIImage * ghostImage = [self createPaddedGhostImageWithSize:input.size];
    CIImage * ghostCIImage = [[CIImage alloc] initWithImage:ghostImage];
    
    // 3. Apply alpha to Ghosty
    CIFilter * alphaFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    CIVector * alphaVector = [CIVector vectorWithX:0 Y:0 Z:0.5 W:0];
    [alphaFilter setValue:alphaVector forKeyPath:@"inputAVector"];
    
    // 4. Alpha blend filter
    
    CIFilter * blendFilter = [CIFilter filterWithName:@"CISourceAtopCompositing"];
    
    // 5. Apply your filters
    [alphaFilter setValue:ghostCIImage forKeyPath:@"inputImage"];
    ghostCIImage = [alphaFilter outputImage];
    
    [blendFilter setValue:ghostCIImage forKeyPath:@"inputImage"];
    [blendFilter setValue:inputCIImage forKeyPath:@"inputBackgroundImage"];
    CIImage * blendOutput = [blendFilter outputImage];
    
    [grayFilter setValue:blendOutput forKeyPath:@"inputImage"];
    CIImage * outputCIImage = [grayFilter outputImage];
    
    // 6. Render your output image
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef outputCGImage = [context createCGImage:outputCIImage fromRect:[outputCIImage extent]];
    UIImage * outputImage = [UIImage imageWithCGImage:outputCGImage];
    CGImageRelease(outputCGImage);
    
    return outputImage;
}


- (UIImage *)processSubtractUsingCoreImage:(UIImage *)input {
    CIImage * inputCIImage = [[CIImage alloc] initWithImage:input];
    
    // Use Core Graphics for this
    UIImage * ghostImage = [self createPaddedGhostImageWithSize:input.size];
    CIImage * ghostCIImage = [[CIImage alloc] initWithImage:ghostImage];
    
    // 1. Create a grayscale filter
    CIFilter * filter = [CIFilter filterWithName:@"CISubtractBlendMode"];
    [filter setValue:ghostCIImage forKeyPath:kCIInputImageKey];
    [filter setValue:inputCIImage forKeyPath:kCIInputBackgroundImageKey];
    CIImage * outputCIImage = [filter outputImage];
    // 6. Render your output image
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef outputCGImage = [context createCGImage:outputCIImage fromRect:[outputCIImage extent]];
    UIImage * outputImage = [UIImage imageWithCGImage:outputCGImage];
    CGImageRelease(outputCGImage);
    
    return outputImage;
}


- (UIImage *)createPaddedGhostImageWithSize:(CGSize)inputSize {
    UIImage * ghostImage = [UIImage imageNamed:@"ghost.png"];
    CGFloat ghostImageAspectRatio = ghostImage.size.width / ghostImage.size.height;
    
    NSInteger targetGhostWidth = inputSize.width * 0.25;
    CGSize ghostSize = CGSizeMake(targetGhostWidth, targetGhostWidth / ghostImageAspectRatio);
    CGPoint ghostOrigin = CGPointMake(inputSize.width * 0.5, inputSize.height * 0.2);
    
    CGRect ghostRect = {ghostOrigin, ghostSize};
    
    UIGraphicsBeginImageContext(inputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGRect inputRect = {CGPointZero, inputSize};
    CGContextClearRect(context, inputRect);
    
    
    CGContextAddRect(context, CGRectMake(0, 0, inputSize.width, inputSize.height));
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextFillPath(context);
    
    CGAffineTransform flip = CGAffineTransformMakeScale(1.0, -1.0);
    CGAffineTransform flipThenShift = CGAffineTransformTranslate(flip,0,-inputSize.height);
    CGContextConcatCTM(context, flipThenShift);
    CGRect transformedGhostRect = CGRectApplyAffineTransform(ghostRect, flipThenShift);
    CGContextDrawImage(context, transformedGhostRect, [ghostImage CGImage]);
    
    UIImage * paddedGhost = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return paddedGhost;
}


@end
