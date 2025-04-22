import { WebPlugin } from '@capacitor/core';

import type { OcrPlugin } from './definitions';

export class OcrWeb extends WebPlugin implements OcrPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
