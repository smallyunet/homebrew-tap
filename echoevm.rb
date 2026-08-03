class Echoevm < Formula
  desc "EVM debugger, tracer, differential tester, and replay tool"
  homepage "https://github.com/smallyunet/echoevm"
  url "https://github.com/smallyunet/echoevm/archive/refs/tags/v0.0.35.tar.gz"
  sha256 "6437874d16256b4a70e9bed26148acacca76542fab3779361bc6aa59f0f1c7c6"
  license "MIT"
  head "https://github.com/smallyunet/echoevm.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s
      -w
      -X main.Version=v#{version}
      -X main.GitCommit=0b107294880890660fefe4c7b86b6a0216ff82e3
      -X main.BuildDate=2026-08-02T14:57:49Z
    ]
    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/echoevm"
  end

  test do
    assert_match "echoevm v#{version}", shell_output("#{bin}/echoevm version")
    assert_match "Usage:", shell_output("#{bin}/echoevm --help")
  end
end
