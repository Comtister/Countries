//
//  SVGImageProcessor.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 9.01.2022.
//

import Foundation
import Kingfisher
import SVGKit

public struct SVGImageProcessor : ImageProcessor{
    public var identifier: String = "com.appidentifier.webpprocessor"
        public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
            switch item {
            case .image(let image):
                print("already an image")
                return image
            case .data(let data):
                print("sadas")
                let imsvg = SVGKImage(data: data)
                return imsvg?.uiImage
            }
        }
}
