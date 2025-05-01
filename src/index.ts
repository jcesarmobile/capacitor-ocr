import { registerPlugin } from '@capacitor/core';

import type { OcrPlugin } from './definitions';

const Ocr = registerPlugin<OcrPlugin>('Ocr');

export * from './definitions';
export { Ocr };
