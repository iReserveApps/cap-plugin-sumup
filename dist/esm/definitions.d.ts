declare module '@capacitor/core' {
    interface PluginRegistry {
        SumUp: SumUpPlugin;
    }
}
export interface SumUpResponse {
    code: number;
    message: string;
    transactionId?: string;
}
export interface CheckoutOptions {
    total: number;
    currency: string;
    title?: string;
    transactionIdentifier?: string;
    transactionIdPrefix?: string;
}
export interface LoginOptions {
}
export interface SetupOptions {
    apiKey: string;
}
export interface SumUpPlugin {
    setup(options: SetupOptions): Promise<SumUpResponse>;
    login(options: LoginOptions): Promise<SumUpResponse>;
    checkout(options: CheckoutOptions): Promise<SumUpResponse>;
}
