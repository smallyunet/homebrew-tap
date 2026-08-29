class Echoevm < Formula
  desc "Self-contained Rust EVM debugger, tracer, and replay engine"
  homepage "https://github.com/smallyunet/echoevm"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.8.0/echoevm-darwin-arm64"
      sha256 "5ffa3b24710664e4ef19b88a0a506826b7ef0d08f19ca86a15c36e74f846b9eb"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.8.0/echoevm-darwin-amd64"
      sha256 "cd86e72ba4486986e66eeebcd36bfd2bf35e8af55cb3d8c51c10605ef0c44fc5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.8.0/echoevm-linux-arm64"
      sha256 "b53bb04ad83ba1209f2c1d2f8c487bdbb90dff3d1b1aa8e1a5e8f03021311754"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.8.0/echoevm-linux-amd64"
      sha256 "6f408bdea2c12b87ddfdf8440368ce8c5ffc41d14af5893fb2760d87d954e006"
    end
  end

  def install
    bin.install cached_download => "echoevm"
  end

  test do
    assert_match '"version":"1.8.0"', shell_output("#{bin}/echoevm version --json")
    assert_match '"status": "success"', shell_output("#{bin}/echoevm run 0x600260030100 --json")
  end
end
