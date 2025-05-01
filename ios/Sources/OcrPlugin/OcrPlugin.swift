import Foundation
import Capacitor
import Vision

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(OcrPlugin)
public class OcrPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "OcrPlugin"
    public let jsName = "Ocr"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "process", returnType: CAPPluginReturnPromise)
    ]

    @objc func process(_ call: CAPPluginCall) {
        if let imageString = call.getString("image"), let imageURL = URL(string: imageString) {
            if #available(iOS 18.0, *) {
                Task {
                    let request = RecognizeTextRequest()
                    do {
                        let textObservations = try await request.perform(on: imageURL)
                        var results = JSArray()
                        for textObservation in textObservations {
                            var observation = JSObject()
                            if let firstCandidate = textObservation.topCandidates(1).first {
                                observation["text"] = firstCandidate.string
                                observation["confidence"] = firstCandidate.confidence
                                results.append(observation)
                            }
                        }
                        call.resolve([
                            "results": results
                        ])
                    } catch let error {
                        call.reject(error.localizedDescription)
                    }
                }
            } else {
                let requestHandler = VNImageRequestHandler(url: imageURL)
                let textDetectionRequest = VNRecognizeTextRequest { (request, error) in
                    if let error = error {
                        call.reject(error.localizedDescription)
                        return
                    }

                    if let textObservations = request.results as? [VNRecognizedTextObservation] {
                        var results = JSArray()
                        for textObservation in textObservations {
                            var observation = JSObject()
                            if let firstCandidate = textObservation.topCandidates(1).first {
                                observation["text"] = firstCandidate.string
                                observation["confidence"] = firstCandidate.confidence
                                results.append(observation)
                            }
                        }
                        call.resolve([
                            "results": results
                        ])
                    }
                }

                do {
                    try requestHandler.perform([textDetectionRequest])
                } catch {
                    call.reject(error.localizedDescription)
                }
            }
        } else {
            call.reject("invalid image")
        }

    }

}
