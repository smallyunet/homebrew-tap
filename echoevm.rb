class Echoevm < Formula
  desc "Self-contained Rust EVM debugger, tracer, and replay engine"
  homepage "https://github.com/smallyunet/echoevm"
  version "1.4.0"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.4.0/echoevm-darwin-arm64"
      sha256 "9bc80e3851cd8550a9502324231cbfcf130400f27985b9edea885a475b0b5a69"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.4.0/echoevm-darwin-amd64"
      sha256 "62d25921223220d2006e1dfd41bd77cfa1a3e763f880d8ce9d5cee231d3728d4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.4.0/echoevm-linux-arm64"
      sha256 "bba334e4a9c041397270cfb8a43c62ce7d0bf714c8251f34fabe128569492ab4"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.4.0/echoevm-linux-amd64"
      sha256 "0d60faac6a32b29ad6668a37e30ac81913057b65ea3c436de15569a8b19721f1"
    end
  end

  def install
    bin.install cached_download => "echoevm"
  end

  test do
    assert_match '"version":"1.4.0"', shell_output("#{bin}/echoevm version --json")
    assert_match '"status": "success"', shell_output("#{bin}/echoevm run 0x600260030100 --json")
  end
end
