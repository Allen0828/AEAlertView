//
//  AEAlertTools.swift
//  dev-alert
//
//  Created by Allen0828 on 2023/7/23.
//

import UIKit

extension UIApplication {
    func alertGetCurrentWindow() -> UIWindow? {
        if Thread.isMainThread {
            if #available(iOS 13, *) {
                let connectedScenes = UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .compactMap({$0 as? UIWindowScene})
                if connectedScenes.count == 0 {
                    return UIApplication.shared.windows.first
                }
                let window = connectedScenes.first?
                    .windows
                    .first { $0.isKeyWindow }
                return window
            } else if #available(iOS 8.0, *) {
                return UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow
            } else {
                return UIApplication.shared.windows.first { $0.isKeyWindow }
            }
        }
        return nil
    }
}

enum ImageFormat {
    case Unknow
    case JPEG
    case PNG
    case GIF
    case TIFF
    case WebP
    case HEIC
    case HEIF
}
extension Data {
    func alertGetImageFormat() -> ImageFormat  {
        var buffer = [UInt8](repeating: 0, count: 1)
        self.copyBytes(to: &buffer, count: 1)
        
        switch buffer {
        case [0xFF]: return .JPEG
        case [0x89]: return .PNG
        case [0x47]: return .GIF
        case [0x49],[0x4D]: return .TIFF
        case [0x52] where self.count >= 12:
            if let str = String(data: self[0...11], encoding: .ascii), str.hasPrefix("RIFF"), str.hasSuffix("WEBP") {
                return .WebP
            }
        case [0x00] where self.count >= 12:
            if let str = String(data: self[8...11], encoding: .ascii) {
                let HEICBitMaps = Set(["heic", "heis", "heix", "hevc", "hevx"])
                if HEICBitMaps.contains(str) {
                    return .HEIC
                }
                let HEIFBitMaps = Set(["mif1", "msf1"])
                if HEIFBitMaps.contains(str) {
                    return .HEIF
                }
            }
        default: break;
        }
        return .Unknow
    }
}


// MARK: - AEAlertTextView
public class AEAlertTextView: UITextView {
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textContainerInset = UIEdgeInsets.zero
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        if !self.bounds.size.equalTo(self.intrinsicContentCGSize()) {
            invalidateIntrinsicContentSize()
        }
    }
    private func intrinsicContentCGSize() -> CGSize {
        if self.text.count > 0 {
            return self.contentSize
        } else {
            return CGSize.zero
        }
    }
}
