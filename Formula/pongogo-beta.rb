class PongogoBeta < Formula
  desc "AI agent knowledge routing for Claude Code"
  homepage "https://pongogo.com"
  url "https://get.pongogo.com/releases/pongogo-0.3.19-beta.1.tar.gz"
  sha256 "77faa9a6d59c361b1099595ba514db8cc3247c51580af77d4253e63d29c07f3d"
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
