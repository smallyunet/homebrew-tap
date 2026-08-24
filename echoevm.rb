class Echoevm < Formula
  desc "Self-contained Rust EVM debugger, tracer, and replay engine"
  homepage "https://github.com/smallyunet/echoevm"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.6.0/echoevm-darwin-arm64"
      sha256 "611a89734c3c899442aaa637a0a09fee859f0bb57df44598b0daa16bd6438c85"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.6.0/echoevm-darwin-amd64"
      sha256 "5d155a18507545026c5245840e3a3aa659b2bb13f750a49f96dd2b625c56b67d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.6.0/echoevm-linux-arm64"
      sha256 "a435aceb9d62eafc2fca3e1203c6f924eb84afd5012c9ad32f22149eac071158"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.6.0/echoevm-linux-amd64"
      sha256 "38c4dba5c82378201a68d2e51627a4e96c45d935940b90b7d47500483f0b7987"
    end
  end

  def install
    bin.install cached_download => "echoevm"
  end

  test do
    assert_match '"version":"1.6.0"', shell_output("#{bin}/echoevm version --json")
    assert_match '"status": "success"', shell_output("#{bin}/echoevm run 0x600260030100 --json")
  end
end
