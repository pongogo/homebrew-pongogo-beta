class PongogoBeta < Formula
  desc "AI agent knowledge routing for Claude Code"
  homepage "https://pongogo.com"
  url "https://get.pongogo.com/releases/pongogo-0.3.20-beta.2.tar.gz"
  sha256 "cf657a57823f7575df9da8db8aae414a3b2ad4d2f9544497393a34b81ba4fd65"
  license "MIT"

  depends_on "python@3.12"

  # Skip Homebrew dylib ID fixup for Python native extensions.
  # Python uses dlopen() (not Mach-O dyld), so rpath rewriting is
  # unnecessary and fails on extensions with insufficient header
  # padding (pydantic_core, cryptography).
  skip_clean "libexec"

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
