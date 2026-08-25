class Echoevm < Formula
  desc "Self-contained Rust EVM debugger, tracer, and replay engine"
  homepage "https://github.com/smallyunet/echoevm"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.7.0/echoevm-darwin-arm64"
      sha256 "f5542b9e170cbbcbffa5f819217508bac8a8e8ae0f3ef94fa238174611bd2eae"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.7.0/echoevm-darwin-amd64"
      sha256 "045d126ab4084a140caec9de1b27c4b356d68b11561e4bafd990586c74571bba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.7.0/echoevm-linux-arm64"
      sha256 "2465e22774f50f19f3ef8e26967e803059944c06d04062178025664d046d9e8a"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.7.0/echoevm-linux-amd64"
      sha256 "d4d417438008376b402048900e2db842a65ef25fae87e511de9a669164c16321"
    end
  end

  def install
    bin.install cached_download => "echoevm"
  end

  test do
    assert_match '"version":"1.7.0"', shell_output("#{bin}/echoevm version --json")
    assert_match '"status": "success"', shell_output("#{bin}/echoevm run 0x600260030100 --json")
  end
end
