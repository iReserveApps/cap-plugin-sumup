import { WebPlugin } from '@capacitor/core';
import { SumUpPlugin } from './definitions';

export class SumUpWeb extends WebPlugin implements SumUpPlugin {
  constructor() {
    super({
      name: 'SumUp',
      platforms: ['web'],
    });
  }

  async setup(options: { apiKey: string }): Promise<{ code: number, message: string }> {
    console.log('setup', options);
    return { code: 0, message: 'not implemented for web' };
  }

  async login(options: { }): Promise<{ code: number, message: string }> {
    console.log('login', options);
    return { code: 0, message: 'not implemented for web' };
  }

  async checkout(options: { total: number, currency: string }): Promise<{ code: number, message: string }> {
    console.log('checkout', options);
    return { code: 0, message: 'not implemented for web' };
  }
}

const SumUp = new SumUpWeb();

export { SumUp };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(SumUp);
