class PongogoBeta < Formula
  desc "AI agent knowledge routing for Claude Code"
  homepage "https://pongogo.com"
  url "https://get.pongogo.com/releases/pongogo-0.3.16-beta.11.tar.gz"
  sha256 "ce889e453a03180679198d09945fa86cc0d5e76b54255bbc9377c24f4b28d0b1"
  license "MIT"

  depends_on "python@3.12"

  def install
    python3 = "python3.12"

    # Create virtualenv
    system python3, "-m", "venv", libexec

    # Install from source
    system libexec/"bin/pip", "install", "."

    # Link the entry point scripts to bin
    bin.install_symlink Dir[libexec/"bin/pongogo*"]
  end

  test do
    system "#{bin}/pongogo", "--version"
  end
end
