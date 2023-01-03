import { registerPlugin } from '@capacitor/core';

import type { htmltodataPlugin } from './definitions';

const htmltodata = registerPlugin<htmltodataPlugin>('htmltodata', {
  web: () => import('./web').then(m => new m.htmltodataWeb()),
});

export * from './definitions';
export { htmltodata };
