import { WebPlugin } from '@capacitor/core';
import { SumUpPlugin } from './definitions';
export declare class SumUpWeb extends WebPlugin implements SumUpPlugin {
    constructor();
    setup(options: {
        apiKey: string;
    }): Promise<{
        code: number;
        message: string;
    }>;
    login(options: {
        affiliateKey: string;
    }): Promise<{
        code: number;
        message: string;
    }>;
    checkout(options: {
        total: number;
        currency: string;
    }): Promise<{
        code: number;
        message: string;
    }>;
}
declare const SumUp: SumUpWeb;
export { SumUp };
