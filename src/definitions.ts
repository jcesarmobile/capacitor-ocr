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
   * Only file urls (as the ones returned by Camera plugin) are supported at the moment.
   *
   * @param image
   */
  process(options: { image: string }): Promise<RecognitionResults>;
}
