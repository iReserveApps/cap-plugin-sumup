var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { WebPlugin } from '@capacitor/core';
export class SumUpWeb extends WebPlugin {
    constructor() {
        super({
            name: 'SumUp',
            platforms: ['web'],
        });
    }
    setup(options) {
        return __awaiter(this, void 0, void 0, function* () {
            console.log('setup', options);
            return { code: 0, message: 'not implemented for web' };
        });
    }
    login(options) {
        return __awaiter(this, void 0, void 0, function* () {
            console.log('login', options);
            return { code: 0, message: 'not implemented for web' };
        });
    }
    checkout(options) {
        return __awaiter(this, void 0, void 0, function* () {
            console.log('checkout', options);
            return { code: 0, message: 'not implemented for web' };
        });
    }
}
const SumUp = new SumUpWeb();
export { SumUp };
import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(SumUp);
//# sourceMappingURL=web.js.map