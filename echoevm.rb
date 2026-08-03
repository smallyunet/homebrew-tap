class Echoevm < Formula
  desc "EVM debugger, tracer, differential tester, and replay tool"
  homepage "https://github.com/smallyunet/echoevm"
  url "https://github.com/smallyunet/echoevm/archive/refs/tags/v0.0.37.tar.gz"
  sha256 "8e3e321969ee56b6a880da0967fc3c5f09815f041c6dc87ff27b6608752ff5cf"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s
      -w
      -X main.Version=v#{version}
      -X main.GitCommit=bee203b8ae09bc2e044275b23c359462ba03410e
      -X main.BuildDate=2026-08-03T07:25:49Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/echoevm"
  end

  test do
    assert_match "echoevm v#{version}", shell_output("#{bin}/echoevm version")
    assert_match "Usage:", shell_output("#{bin}/echoevm --help")
  end
end
