package com.jcesarmobile.capacitor.ocr;

import android.net.Uri;
import com.getcapacitor.JSArray;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.google.mlkit.vision.common.InputImage;
import com.google.mlkit.vision.text.Text;
import com.google.mlkit.vision.text.TextRecognition;
import com.google.mlkit.vision.text.TextRecognizer;
import com.google.mlkit.vision.text.latin.TextRecognizerOptions;
import java.io.IOException;

@CapacitorPlugin(name = "Ocr")
public class OcrPlugin extends Plugin {

    @PluginMethod
    public void process(PluginCall call) {
        String imageString = call.getString("image");
        TextRecognizer recognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS);
        try {
            InputImage image = InputImage.fromFilePath(getContext(), Uri.parse(imageString));
            recognizer
                .process(image)
                .addOnSuccessListener((visionText) -> {
                    var resultsArray = new JSArray();
                    for (Text.TextBlock block : visionText.getTextBlocks()) {
                        for (Text.Line line : block.getLines()) {
                            var observation = new JSObject();
                            observation.put("text", line.getText());
                            observation.put("confidence", line.getConfidence());
                            resultsArray.put(observation);
                        }
                    }
                    var results = new JSObject();
                    results.put("results", resultsArray);
                    call.resolve(results);
                })
                .addOnFailureListener((e) -> call.reject("failure", e));
        } catch (IOException e) {
            call.reject("error reading image", e);
        }
    }
}
