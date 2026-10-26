cask "t3-code" do
  # The app updates itself from the fork's GitHub releases, so the cask always
  # installs the newest release and never pins a version or a checksum.
  version :latest
  sha256 :no_check

  url "https://github.com/abelkocsis/t3code/releases/latest/download/T3-Code-arm64.dmg"
  name "T3 Code"
  desc "BitSafe's fork of T3 Code, a GUI for coding agents"
  homepage "https://github.com/abelkocsis/t3code"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "T3 Code (Beta).app"

  # Releases are unsigned, so Gatekeeper calls the app damaged until the
  # quarantine flag is cleared once.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/T3 Code (Beta).app"]
  end

  uninstall quit: "com.t3tools.t3code"

  # ~/.t3 holds the user's threads and projects. It stays on zap.
  zap trash: [
    "~/Library/Application Support/T3 Code (Beta)",
    "~/Library/Caches/com.t3tools.t3code",
    "~/Library/Preferences/com.t3tools.t3code.plist",
    "~/Library/Saved Application State/com.t3tools.t3code.savedState",
  ]
end
