class Echoevm < Formula
  desc "Self-contained Rust EVM debugger, tracer, and replay engine"
  homepage "https://github.com/smallyunet/echoevm"
  version "1.5.0"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.5.0/echoevm-darwin-arm64"
      sha256 "d01b277dd374b63a304014ff2fc49edb926a6e719301417bcd538c22b74ff0fa"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.5.0/echoevm-darwin-amd64"
      sha256 "ff8299d4a2387be097cc0263e50dd02d8895d7d1801ee70afd660f0536d47261"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/echoevm/releases/download/v1.5.0/echoevm-linux-arm64"
      sha256 "0864263f44d4f5382808652231ea808382d1f331e75d6337017a3e9822ef204f"
    else
      url "https://github.com/smallyunet/echoevm/releases/download/v1.5.0/echoevm-linux-amd64"
      sha256 "ef917430a146cd9af93d46e83b1f19dad49039979b70628df2b9d0c3d3b9dcda"
    end
  end

  def install
    bin.install cached_download => "echoevm"
  end

  test do
    assert_match '"version":"1.5.0"', shell_output("#{bin}/echoevm version --json")
    assert_match '"status": "success"', shell_output("#{bin}/echoevm run 0x600260030100 --json")
  end
end
