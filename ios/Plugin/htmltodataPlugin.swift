import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(htmltodataPlugin)
public class htmltodataPlugin: CAPPlugin, PassHTMLContent {
    private let implementation = htmltodata()
    var htmlContentCAPPluginCall = CAPPluginCall();

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

     @objc func htmlstringToBase64(_ call: CAPPluginCall) {
        let valueHtmlContent = call.getString("value") ?? ""
        htmlContentCAPPluginCall = call
        DispatchQueue.main.async {
            let webVC = WebViewVC()
            webVC.htmlContentString = valueHtmlContent
            webVC.delegatePassHTMLContent = self
            self.bridge?.viewController?.present(webVC, animated: true)
//            UIApplication.shared.windows.first?.rootViewController?.present(webVC, animated: true)
        }
    }

    func passHTMLContent(base64: String) {
        htmlContentCAPPluginCall.resolve([
            "value": implementation.echo(base64)
        ])
        self.bridge?.viewController?.dismiss(animated: true)
    }
}
