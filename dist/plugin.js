var capacitorhtmltodata = (function (exports, core) {
    'use strict';

    const htmltodata = core.registerPlugin('htmltodata', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.htmltodataWeb()),
    });

    class htmltodataWeb extends core.WebPlugin {
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

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        htmltodataWeb: htmltodataWeb
    });

    exports.htmltodata = htmltodata;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
