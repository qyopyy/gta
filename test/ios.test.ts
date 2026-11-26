import { describe, expect, it } from 'bun:test';
import { canShowInstallHint, isIOS, isStandalone } from '../public/js/ios.js';

const IPHONE = 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Mobile/15E148 Safari/604.1';
const MAC = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15';
const ANDROID = 'Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Mobile Safari/537.36';

describe('iOS detection', () => {
  it('recognises iPhone and iPadOS (which poses as a touch Mac) but not Mac or Android', () => {
    expect(isIOS(IPHONE, 'iPhone', 5)).toBe(true);
    expect(isIOS(MAC, 'MacIntel', 5)).toBe(true);
    expect(isIOS(MAC, 'MacIntel', 0)).toBe(false);
    expect(isIOS(ANDROID, 'Linux armv8l', 5)).toBe(false);
  });

  it('knows when it runs from the Home Screen', () => {
    expect(isStandalone({ standalone: true } as Navigator, () => ({ matches: false }) as MediaQueryList)).toBe(true);
    expect(isStandalone({} as Navigator, () => ({ matches: true }) as MediaQueryList)).toBe(true);
    expect(isStandalone({} as Navigator, () => ({ matches: false }) as MediaQueryList)).toBe(false);
    expect(isStandalone({} as Navigator, undefined)).toBe(false);
  });

  it('shows the install tip only in iOS browsers that are not already installed', () => {
    expect(canShowInstallHint(IPHONE, 'iPhone', 5, false)).toBe(true);
    expect(canShowInstallHint(IPHONE, 'iPhone', 5, true)).toBe(false);
    expect(canShowInstallHint(ANDROID, 'Linux armv8l', 5, false)).toBe(false);
    expect(canShowInstallHint(`${IPHONE} Instagram 300.0`, 'iPhone', 5, false)).toBe(false);
  });
});
