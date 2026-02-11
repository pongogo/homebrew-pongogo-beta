class PongogoBeta < Formula
  desc "AI agent knowledge routing for Claude Code"
  homepage "https://pongogo.com"
  url "https://get.pongogo.com/releases/pongogo-0.3.20-beta.1.tar.gz"
  sha256 "8ec33dda4491b5e7426205bf5dd2a444d7e52f77be9619e3ce8f6a09e0b9f361"
  license "MIT"

  depends_on "python@3.12"

  def install
    python3 = "python3.12"

    # Create virtualenv
    system python3, "-m", "venv", libexec

    # Install from source
    system libexec/"bin/pip", "install", "."

    # Remove unused cryptography Rust extension to prevent Homebrew
    # dylib fixup errors on macOS (insufficient Mach-O header padding).
    # Dep chain: fastmcp -> authlib -> cryptography (unused by pongogo).
    system libexec/"bin/pip", "uninstall", "-y",
      "cryptography", "cffi", "pycparser"

    # Link the entry point scripts to bin
    bin.install_symlink Dir[libexec/"bin/pongogo*"]
  end

  test do
    system "#{bin}/pongogo", "--version"
  end
end
