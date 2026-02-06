export interface RecognitionResults {
  /**
   * List of recognized texts
   *
   * @since 0.0.1
   */
  results: RecognitionResult[];
}

export interface RecognitionResult {
  /**
   * The recognized text.
   *
   * @since 0.0.1
   */
  text: string;
  /**
   * The confidence of the recognized text.
   *
   * @since 0.0.1
   */
  confidence: number;
}

export interface OcrPlugin {
  /**
   * Process the text on the provided image.
   * Can be a file URL (returned by Camera plugin by using CameraResultType.Uri)
   * or a base64 data URL (returned by Camera plugin by using CameraResultType.DataUrl).
   *
   * Example:
   *   { image: 'file:///path/to/image.jpg' }
   *   { image: 'data:image/png;base64,iVBORw0KG...' }
   *
   * @param image
   */
  process(options: { image: string }): Promise<RecognitionResults>;
}
