export interface htmltodataPlugin {
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
