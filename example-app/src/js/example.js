import { Ocr } from '@jcesarmobile/capacitor-ocr';
import { Camera, CameraResultType, CameraSource } from '@capacitor/camera';


window.testEcho = async () => {
    const image = await Camera.getPhoto({
        quality: 90,
        allowEditing: false,
        resultType: CameraResultType.Uri,
        source: CameraSource.Camera
      });
    const { results } = await Ocr.process({ image: image.path });
    const resultBox = document.getElementById("results");
    let resultString = "";
    console.log('results',results);
    for (const result of results) {
      console.log('result',result);
      resultString += `${result.text} (${result.confidence})\n`;
    }
    resultBox.innerText = resultString;
}

// New: take a picture and return a data URL (base64) and perform OCR on it
window.testEchoBase64 = async () => {
    const image = await Camera.getPhoto({
        quality: 90,
        allowEditing: false,
        resultType: CameraResultType.DataUrl,
        source: CameraSource.Camera
    });

    // image.dataUrl is a data URL like: data:image/png;base64,...
    const { results } = await Ocr.process({ image: image.dataUrl });
    const resultBox = document.getElementById("results");
    let resultString = "";
    for (const result of results) {
      resultString += `${result.text} (${result.confidence})\n`;
    }
    resultBox.innerText = resultString;
}
