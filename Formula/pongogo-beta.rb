class PongogoBeta < Formula
  desc "AI agent knowledge routing for Claude Code"
  homepage "https://pongogo.com"
  url "https://get.pongogo.com/releases/pongogo-0.3.18-beta.1.tar.gz"
  sha256 "3265742fa90bdf3a4fe3124ab75778aeefa28640b054f55666ae60419001d9b8"
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
