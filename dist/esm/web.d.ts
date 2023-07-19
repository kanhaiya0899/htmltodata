import { WebPlugin } from '@capacitor/core';
import type { htmltodataPlugin } from './definitions';
export declare class htmltodataWeb extends WebPlugin implements htmltodataPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    htmlstringToBase64(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    printDefaultiOS(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
