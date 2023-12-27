//
//  WebViewVC.swift
//  Plugin
//
//  Created by iMac on 03/01/23.
//  Copyright © 2023 Max Lynch. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {
    
    //MARK: Properties
    var webView:WKWebView?
    var htmlView = PSHTMLView()
    var htmlContentString = String()
    var delegatePassHTMLContent: PassHTMLContent? = nil
    
    var scrollView: UIScrollView!
    
    //MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.view.backgroundColor = .none
        } else {
            self.view.backgroundColor = .white
        }
        
        self.htmlView.frame = CGRect(x: 0, y: 0, width: 600, height: 0)
        
        self.view.addSubview(htmlView)
        
        htmlView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        htmlView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        htmlView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        htmlView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.htmlView.backgroundColor = .yellow
        htmlView.html = htmlContentString
        htmlView.delegate = self
    }
}

//MARK: PSHTMLViewDelegate
extension WebViewVC: PSHTMLViewDelegate {
    func presentAlert(_ alertController: UIAlertController) {
        print("")
    }
    
    func heightChanged(height: CGFloat) {
        print("")
    }
    
    func shouldNavigate(for navigationAction: WKNavigationAction) -> Bool {
        return true
    }
    
    func handleScriptMessage(_ message: WKScriptMessage) {
        print("")
    }
    
    func loadingProgress(progress: Float) {
        print("")
    }
    
    func didFinishLoad() {
        
        self.htmlView.frame = CGRect(x: 0, y: 0, width: 292, height: htmlView.webViewHeightConstraint.constant)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let image = self.htmlView.image()
            let resizeImage = self.imageWithImage(sourceImage: image!, scaledToWidth: self.htmlView.frame.width * 2)
            let imageData:Data = (resizeImage.pngData())!
            let imageBase64String = imageData.base64EncodedString()
            self.delegatePassHTMLContent?.passHTMLContent(base64: imageBase64String)
        }
    }
    
    func imageWithImage (sourceImage:UIImage, scaledToWidth: CGFloat) -> UIImage {
        let oldWidth = sourceImage.size.width
        let scaleFactor = scaledToWidth / oldWidth
        
        let newHeight = sourceImage.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        sourceImage.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

//MARK: Image screenshot
extension UIView {
    
    class func image(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: ctx)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func image() -> UIImage? {
        return UIView.image(view: self)
    }
}

protocol PassHTMLContent {
    func passHTMLContent(base64: String)
}
