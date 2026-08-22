class Echoevm < Formula
  desc "Self-contained Rust EVM debugger, tracer, and replay engine"
  homepage "https://github.com/smallyunet/echoevm"
  version "1.0.0"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.0.0/echoevm-darwin-arm64"
      sha256 "41e1979572c85d62730d4b98758df1c7bcd3c8dadab66e887783fadcc6b2380f"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.0.0/echoevm-darwin-amd64"
      sha256 "651f83b25e68a4c6e4a92b5c06628b5b89c3d7191aceaf6288f63bfb9d70e987"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.0.0/echoevm-linux-arm64"
      sha256 "b0c1772e6f809d27126e2a40746d9cf5339d1545b9f94babf12ba4bcec204a7e"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.0.0/echoevm-linux-amd64"
      sha256 "9f0a0ac521cfc137e46db296ba1b102903270c89da948d3014a1b5a3f9bda97f"
    end
  end

  def install
    bin.install cached_download => "echoevm"
  end

  test do
    assert_match '"version":"1.0.0"', shell_output("#{bin}/echoevm version --json")
    assert_match '"status": "success"', shell_output("#{bin}/echoevm run 0x600260030100 --json")
  end
end
