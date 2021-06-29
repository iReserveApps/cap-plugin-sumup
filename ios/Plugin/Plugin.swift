import Foundation
import Capacitor
import SumUpSDK

@objc(SumUp)
public class SumUp: CAPPlugin {

    @objc func setup(_ call: CAPPluginCall) {
        print("SUMUP:CAPPluginCall:setup")
        let apiKey = call.getString("apiKey") ?? ""
        print("apiKey", apiKey)
        
        DispatchQueue.main.async {
            SumUpSDK.testIntegration()
            let setupResult = SumUpSDK.setup(withAPIKey: apiKey)
            print("setupResult", setupResult)

            call.success([
                "code": setupResult, "message": apiKey
            ])
        }
    }

    @objc func login(_ call: CAPPluginCall) {
        print("SUMUP:CAPPluginCall:login")
        if (SumUpSDK.isLoggedIn) {
            call.success([
                "code": 1, "message": "Logged in"
            ])
        } else {
            DispatchQueue.main.async {
                SumUpSDK.presentLogin(from: self.bridge.viewController, animated: true, completionBlock: nil)
            }
            call.success([
                "code": 0, "message": "Login"
            ])
        }
    }

    @objc func checkout(_ call: CAPPluginCall) {
        print("SUMUP:CAPPluginCall:checkout")
        let total = call.getString("total") ?? "0"
        let totalFloat = NSDecimalNumber(string: total)
        print("checkout", total)
        print("totalFloat", totalFloat)
        let titleStr = call.getString("title") ?? "Kassa"
        let currencyStr = call.getString("currency") ?? "EUR"
        let identifierStr = call.getString("transactionIdPrefix") ?? "0"
        let transactionId = call.getString("transactionIdentifier") ?? "\(identifierStr)-\(ProcessInfo.processInfo.globallyUniqueString)"

        DispatchQueue.main.async {
            let request = CheckoutRequest(total: totalFloat, title: titleStr, currencyCode: currencyStr)
            request.foreignTransactionID = transactionId
            print("request.foreignTransactionID", transactionId)
            let vc = self.bridge.viewController

            SumUpSDK.checkout(with: request, from: self.bridge.viewController) { [weak vc] (result: CheckoutResult?, error: Error?) in
                if let safeError = error as NSError? {
                    print("SUMUP:CAPPluginCall:error during checkout: \(safeError)")
                    var returnmessage = "error"
                    if (safeError.domain == SumUpSDKErrorDomain) && (safeError.code == SumUpSDKError.accountNotLoggedIn.rawValue) {
                        returnmessage = "not logged in"
                    } else {

                        print("Start Log error to console=======")
                        print(safeError.code)
                        print(safeError.userInfo)
                        print("End Log error to console=========")

                        returnmessage = safeError.debugDescription
                    }
                    call.reject(returnmessage)
                    return
                }

                guard let safeResult = result else {
                    print("SUMUP:CAPPluginCall:no error and no result should not happen")
                    let returnmessage = "no error and no result should not happen"
                    call.reject(returnmessage)
                    return
                }

                print("result_transaction==\(String(describing: safeResult.transactionCode))")

                if safeResult.success {
                    print("SUMUP:CAPPluginCall:success")
                    print("safeResult", safeResult)
                    var returnmessage = "Thank you - \(String(describing: safeResult.transactionCode))"

                    if let info = safeResult.additionalInfo,
                        let tipAmount = info["tip_amount"] as? Double, tipAmount > 0,
                        let currencyCode = info["currency"] as? String {
                        returnmessage = returnmessage.appending("\ntip: \(tipAmount) \(currencyCode)")
                    }
                    let transactionId = safeResult.transactionCode
                    call.success([
                        "code": 1, "message": returnmessage, "transactionId":transactionId ?? ""
                    ])
                } else {
                    print("SUMUP:CAPPluginCall:cancelled: no error, no success")
                    let returnmessage = "no error, no success"
                    let transactionId = safeResult.transactionCode
                    call.success([
                        "code": 0, "message": returnmessage, "transactionId":transactionId ?? ""
                    ])
                }
            }
        }
    }
}
