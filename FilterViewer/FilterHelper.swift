//
//  FilterHelper.swift
//  FilterViewer
//
//  Created by pikachu987 on 2017. 7. 27..
//  Copyright © 2017년 pikachu987. All rights reserved.
//

import Foundation
import GPUImage

class FilterHelper: NSObject {
    static let shared = FilterHelper()

    private override init() {  }

    func makeFilter(_ image: UIImage, handler: @escaping ((FilterItem) -> Void)){
        self.outputImage("Contrast", image: image, handler: handler) {
            self.outputImage("Exposure", image: image, handler: handler) {
                self.outputImage("Gamma", image: image, handler: handler) {
                    self.outputImage("Hue", image: image, handler: handler) {
                        self.outputImage("Brightness", image: image, handler: handler) {
                            self.outputImage("Saturation", image: image, handler: handler) {
                                self.outputImage("Grayscale", image: image, handler: handler) {
                                    self.outputImage("Sharpen", image: image, handler: handler) {
                                        self.outputImage("Sepia", image: image, handler: handler) {
                                            self.outputImage("RGB-Dark", image: image, handler: handler) {
                                                self.outputImage("RGB-Yellow", image: image, handler: handler) {
                                                    self.outputImage("Monochrome-Blue", image: image, handler: handler) {
                                                        self.outputImage("Monochrome-Red", image: image, handler: handler) {
                                                            self.outputImage("Monochrome-Green", image: image, handler: handler) {

                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func makeFilter(_ name: String) -> GPUImageFilter{
        if name == "Contrast"{
            let filter = GPUImageContrastFilter()
            filter.contrast = 1.2
            return filter
        }else if name == "Exposure"{
            let filter = GPUImageExposureFilter()
            filter.exposure = 0.2
            return filter
        }else if name == "Gamma"{
            let filter = GPUImageGammaFilter()
            filter.gamma = 0.7
            return filter
        }else if name == "Hue"{
            let filter = GPUImageHueFilter()
            filter.hue = 0.488692190558412
            return filter
        }else if name == "Brightness"{
            let filter = GPUImageBrightnessFilter()
            filter.brightness = -0.1
            return filter
        }else if name == "Saturation"{
            let filter = GPUImageSaturationFilter()
            filter.saturation = 1.8
            return filter
        }else if name == "Grayscale"{
            let filter = GPUImageGrayscaleFilter()
            return filter
        }else if name == "Sharpen"{
            let filter = GPUImageSharpenFilter()
            filter.sharpness = -0.44
            return filter
        }else if name == "Sepia"{
            let filter = GPUImageSepiaFilter()
            filter.intensity = 0.5
            return filter
        }else if name == "RGB-Dark"{
            let filter = GPUImageRGBFilter()
            filter.red = 0.788235294117647
            filter.green = 0.898039215686275
            filter.blue = 0.964705882352941
            return filter
        }else if name == "RGB-Yellow"{
            let filter = GPUImageRGBFilter()
            filter.red = 0.945098039215686
            filter.green = 0.937254901960784
            filter.blue = 0.247058823529412
            return filter
        }else if name == "Monochrome-Blue"{
            let filter = GPUImageMonochromeFilter()
            filter.setColorRed(0.290196, green: 0.615686, blue: 0.729412)
            filter.intensity = 0.9
            return filter
        }else if name == "Monochrome-Red"{
            let filter = GPUImageMonochromeFilter()
            filter.setColorRed(0.94902, green: 0.129412, blue: 0.760784)
            filter.intensity = 0.6
            return filter
        }else if name == "Monochrome-Green"{
            let filter = GPUImageMonochromeFilter()
            filter.setColorRed(0.729412, green: 0.866667, blue: 0.12549)
            filter.intensity = 1
            return filter
        }

        return GPUImageFilter()
    }


    private func outputImage(_ name: String, image: UIImage, handler: @escaping ((FilterItem) -> Void), nextHandler: @escaping ((Void) -> Void)){
        DispatchQueue.global().async {
            let filter = self.makeFilter(name)
            let stillImageSource = GPUImagePicture(image: image)
            stillImageSource?.addTarget(filter)
            filter.useNextFrameForImageCapture()
            stillImageSource?.processImage()
            var filterImage = filter.imageFromCurrentFramebuffer()
            if image.imageOrientation == .right{
                filterImage = filterImage?.imageRotatedByDegrees(90, flip: false)
            }
            let item = FilterItem(name, image: filterImage)
            handler(item)
            nextHandler()
        }
    }
}
