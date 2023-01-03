import { registerPlugin } from '@capacitor/core';
const htmltodata = registerPlugin('htmltodata', {
    web: () => import('./web').then(m => new m.htmltodataWeb()),
});
export * from './definitions';
export { htmltodata };
//# sourceMappingURL=index.js.map