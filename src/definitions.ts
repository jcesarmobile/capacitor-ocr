export interface OcrPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
