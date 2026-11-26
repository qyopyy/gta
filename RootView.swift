import SwiftUI

/// Shows the PlayGTA player page full screen. The server address is asked once and remembered;
/// tap with four fingers at once to change it.
struct RootView: View {
    @AppStorage("serverURL") private var serverURL = ""
    @State private var editing = false
    @State private var draft = ""

    private var url: URL? {
        guard let u = URL(string: serverURL), let scheme = u.scheme, ["http", "https"].contains(scheme), u.host != nil else { return nil }
        return u
    }

    var body: some View {
        ZStack {
            Color.black
            if let url, !editing {
                WebView(url: url) { draft = serverURL; editing = true }
            } else {
                VStack(spacing: 14) {
                    Text("PlayGTA server").font(.title2.bold()).foregroundColor(.white)
                    Text("Address of your PlayGTA server, e.g. http://192.168.1.20:3000 or your https tunnel.")
                        .font(.footnote).foregroundColor(.gray).multilineTextAlignment(.center)
                    TextField("https://…", text: $draft)
                        .textInputAutocapitalization(.never).autocorrectionDisabled().keyboardType(.URL)
                        .padding(10).background(Color.white.opacity(0.12)).cornerRadius(8)
                        .foregroundColor(.white).frame(maxWidth: 420)
                    Button("Connect") {
                        var text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !text.contains("://") { text = "http://" + text }
                        serverURL = text
                        editing = false
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(draft.isEmpty)
                }.padding()
            }
        }
    }
}
