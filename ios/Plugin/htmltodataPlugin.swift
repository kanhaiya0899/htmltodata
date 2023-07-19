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

    @objc func printDefaultiOS(_ call: CAPPluginCall) {
        let htmlContent = call.getString("value") ?? ""
        
        DispatchQueue.main.async {
            let printInfo = UIPrintInfo(dictionary:nil)
            printInfo.outputType = UIPrintInfo.OutputType.general
            
            let printController = UIPrintInteractionController.shared
            let formatter = UIMarkupTextPrintFormatter.init(markupText: htmlContent)
            formatter.startPage = 1
            
            printController.printFormatter = formatter
            printController.printInfo = printInfo
            
            printController.present(animated: true) { (controller, completed, error) in
                if !completed, let error = error {
                    print("Error during printing: \(error.localizedDescription)")
                }
            }
        }
    }

    func passHTMLContent(base64: String) {
        htmlContentCAPPluginCall.resolve([
            "value": implementation.echo(base64)
        ])
        self.bridge?.viewController?.dismiss(animated: true)
    }
}
