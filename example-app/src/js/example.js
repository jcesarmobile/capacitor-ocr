import { Ocr } from '@jcesarmobile/capacitor-ocr';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    Ocr.echo({ value: inputValue })
}
