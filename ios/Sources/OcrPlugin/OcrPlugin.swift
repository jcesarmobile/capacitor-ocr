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
        guard let imageString = call.getString("image") else {
            call.reject("missing image")
            return
        }
        var imageData: Data?
        var imageURL: URL?
        if imageString.starts(with: "data:") {
            imageData = Data.capacitor.data(base64EncodedOrDataUrl: imageString)
        } else {
            imageURL = URL(string: imageString)
        }

        if #available(iOS 18.0, *) {
            Task {
                do {
                    let request = RecognizeTextRequest()
                    var textObservations: [RecognizedTextObservation] = []
                    if let imageData {
                        textObservations = try await request.perform(on: imageData)
                    } else if let imageURL {
                        textObservations = try await request.perform(on: imageURL)
                    } else {
                        call.reject("invalid image")
                        return
                    }
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
            var requestHandler: VNImageRequestHandler?
            if let imageData {
                requestHandler = VNImageRequestHandler(data: imageData)
            } else if let imageURL {
                requestHandler = VNImageRequestHandler(url: imageURL)
            } else {
                call.reject("invalid image")
                return
            }
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
                if let requestHandler {
                    try requestHandler.perform([textDetectionRequest])
                }
            } catch {
                call.reject(error.localizedDescription)
            }
        }
    }

}
