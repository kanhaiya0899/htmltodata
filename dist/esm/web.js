import { WebPlugin } from '@capacitor/core';
export class htmltodataWeb extends WebPlugin {
    async echo(options) {
        console.log('ECHO', options);
        return options;
    }
    async htmlstringToBase64(options) {
        return options;
    }
    async printDefaultiOS(options) {
        return options;
    }
}
//# sourceMappingURL=web.js.map