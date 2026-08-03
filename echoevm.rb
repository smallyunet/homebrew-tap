class Echoevm < Formula
  desc "EVM debugger, tracer, differential tester, and replay tool"
  homepage "https://github.com/smallyunet/echoevm"
  url "https://github.com/smallyunet/echoevm/archive/refs/tags/v0.0.36.tar.gz"
  sha256 "e400b005c3028807c3795e307eaa2deee3ee45c79b7cd65b18c6c0dd7e94825b"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s
      -w
      -X main.Version=v#{version}
      -X main.GitCommit=91e449ffe94730619c9bd63636d4c8c859e24597
      -X main.BuildDate=2026-08-03T06:50:35Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/echoevm"
  end

  test do
    assert_match "echoevm v#{version}", shell_output("#{bin}/echoevm version")
    assert_match "Usage:", shell_output("#{bin}/echoevm --help")
  end
end
