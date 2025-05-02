# @jcesarmobile/capacitor-ocr

Capacitor plugin for Optical Character Recognition (OCR).
It does in device text recognition.
On iOS it uses [Vision framework](https://developer.apple.com/documentation/vision/) provided by Apple.
On Android it uses [mlkit](https://developers.google.com/ml-kit/vision/text-recognition/v2) provided by Google.
It has a dependency to `com.google.mlkit:text-recognition`, default version is `16.0.1`, but can be configured with a `textRecognitionVersion` variable in your `variables.gradle file.`

## Install

```bash
npm install @jcesarmobile/capacitor-ocr
npx cap sync
```

## Example

An example app is available in example-app folder.

## API

<docgen-index>

* [`process(...)`](#process)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### process(...)

```typescript
process(options: { image: string; }) => Promise<RecognitionResults>
```

Process the text on the provided image.
Only file urls (as the ones returned by Camera plugin) are supported at the moment.

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ image: string; }</code> |

**Returns:** <code>Promise&lt;<a href="#recognitionresults">RecognitionResults</a>&gt;</code>

--------------------


### Interfaces


#### RecognitionResults

| Prop          | Type                             | Description              | Since |
| ------------- | -------------------------------- | ------------------------ | ----- |
| **`results`** | <code>RecognitionResult[]</code> | List of recognized texts | 0.0.1 |


#### RecognitionResult

| Prop             | Type                | Description                            | Since |
| ---------------- | ------------------- | -------------------------------------- | ----- |
| **`text`**       | <code>string</code> | The recognized text.                   | 0.0.1 |
| **`confidence`** | <code>number</code> | The confidence of the recognized text. | 0.0.1 |

</docgen-api>
