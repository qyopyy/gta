# Playing on a phone (iPhone, iPad, Android)

The player page works in any modern browser. On a touch device it shows two floating joysticks, a D-pad and the
DualSense buttons (L1/L2/R1/R2, ✕○□△, L3/R3, menu) while it is your turn.

## Try it in two minutes (simulated console)

    bun install
    bun start          # http://localhost:3000

To open it on a phone, use your computer's LAN address (e.g. `http://192.168.1.20:3000`) on the same Wi-Fi,
or a tunnel such as `cloudflared tunnel --url http://localhost:3000` for an `https://` address.

## iPhone full screen

Safari on iPhone cannot make a web page full screen. Instead: **Share ⬆️ → Add to Home Screen**, then open
the new icon. It runs without browser bars, in landscape, with the joysticks. The page shows this tip once.
Without installing, the ⛶ button still fills the page (hold the phone sideways).

## Notes

- Pinch and double-tap zoom are off so they don't fight with the sticks.
- The screen stays awake during your turn.
- Real play (not simulated) needs a PS5, chiaki-ng and MediaMTX; see `setup.md`. Behind a tunnel/HTTPS the
  Home Screen app works best.
