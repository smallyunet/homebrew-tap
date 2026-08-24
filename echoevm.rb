class Echoevm < Formula
  desc "Self-contained Rust EVM debugger, tracer, and replay engine"
  homepage "https://github.com/smallyunet/echoevm"
  version "1.5.1"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.5.1/echoevm-darwin-arm64"
      sha256 "a08410100dd2d1347432910ab5bfe5870624032d9261ea8db4b6595a298e937d"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.5.1/echoevm-darwin-amd64"
      sha256 "70601c2ce701333cc95f90668b8ddf97cc548fc7167231fbf32b266d3cf1284b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.5.1/echoevm-linux-arm64"
      sha256 "8f747104448a38e765efea95b60d7b8760e29258f55650f4a0664d3b9fd81ac2"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.5.1/echoevm-linux-amd64"
      sha256 "0d17c31d6d1ae9a4b626ef654d7df02ca94001e66697cdd83bd53b66f3e8b492"
    end
  end

  def install
    bin.install cached_download => "echoevm"
  end

  test do
    assert_match '"version":"1.5.1"', shell_output("#{bin}/echoevm version --json")
    assert_match '"status": "success"', shell_output("#{bin}/echoevm run 0x600260030100 --json")
  end
end
