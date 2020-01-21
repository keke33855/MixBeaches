import UIKit
extension UIImage {
    class func image(from color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    func slice(into howMany: Int) -> [UIImage] {
        let width: CGFloat
        let height: CGFloat
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            width = size.height
            height = size.width
        default:
            width = size.width
            height = size.height
        }
        let tileWidth = Int(width / CGFloat(howMany))
        let tileHeight = Int(height / CGFloat(howMany))
        var images = [UIImage]()
        var adjustedHeight = tileHeight
        var y = 0
        for row in 0 ..< howMany {
            if row == (howMany - 1) {
                adjustedHeight = Int(height) - y
            }
            var adjustedWidth = tileWidth
            var x = 0
            for column in 0 ..< howMany {
                if column == (howMany - 1) {
                    adjustedWidth = Int(width) - x
                }
                let origin = CGPoint(x: x * Int(scale),
                                     y: y * Int(scale))
                let size = CGSize(width: adjustedWidth * Int(scale),
                                  height: adjustedHeight * Int(scale))
                if let tileCgImage = cgImage?.cropping(to: CGRect(origin: origin, size: size)) {
                    images.append(UIImage(cgImage: tileCgImage,
                                          scale: scale,
                                          orientation: imageOrientation))
                }
                x += tileWidth
            }
            y += tileHeight
        }
        return images
    }
}
extension UIImage {
    var renderOriginal: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    var renderTemplate: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
}
private func sp_upload() {
    print("Get Info Failed")
}
private func sp_getUsersMostLiked() {
    print("Check your Network")
}

private func sp_getLoginState() {
    print("Get User Succrss")
}
