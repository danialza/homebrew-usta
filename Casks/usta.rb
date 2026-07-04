cask "usta" do
  version "0.2.0"
  sha256 "77707a8597d13cfcf0371e00c5a7d1c7f2931f0e31a9202cf11bedeb397ad084"

  url "https://github.com/danialza/Usta/releases/download/v#{version}/Usta-macOS-v#{version}.dmg"
  name "Usta"
  desc "Your AI engineering team — native macOS multi-agent IDE"
  homepage "https://github.com/danialza/Usta"

  depends_on macos: :sequoia

  app "Usta.app"

  # The app is not notarized yet; clear the quarantine flag so Gatekeeper
  # doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Usta.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/usta",
    "~/Library/Logs/Usta",
  ]

  caveats <<~EOS
    Usta talks to AI CLIs you already have (claude, codex, gemini, aider)
    and/or API keys you add in Settings. Nothing runs without your keys.
  EOS
end
