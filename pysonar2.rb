# typed: strict
# frozen_string_literal: true

# Homebrew formula for the native PySonar2 semantic CLI and language server.
class Pysonar2 < Formula
  desc "Local-first whole-project Python semantic analysis engine"
  homepage "https://github.com/smallyunet/pysonar2"
  version "4.0.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/pysonar2/releases/download/v4.0.0/pysonar2-v4.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "cdfe1346b57d3ac80fbc43c09ee6e5ed1b041ba38a279270020d875f9fad7478"
    else
      url "https://github.com/smallyunet/pysonar2/releases/download/v4.0.0/pysonar2-v4.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "47fc27fb4b5806e0cee66b3abac753409e46e93a8546d05b2b9fd97088982b34"
    end
  end

  on_linux do
    url "https://github.com/smallyunet/pysonar2/releases/download/v4.0.0/pysonar2-v4.0.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b06ce1174933ca361284a316c165b104d50986081b3825e8ce9ecd54d0956bc1"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "bin/pysonar"
    bin.install "bin/pysonar-lsp"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pysonar --version").strip

    doctor = JSON.parse(shell_output("#{bin}/pysonar doctor --format json"))
    assert_equal "ok", doctor["status"]
    assert_equal "native-rust", doctor["runtime"]
    assert_equal false, doctor.dig("java", "required")
    assert_equal false, doctor.dig("python", "required")

    (testpath/"sample.py").write <<~PYTHON
      def target():
          return 1

      value = target()
    PYTHON
    context = JSON.parse(shell_output(
      "#{bin}/pysonar context --root #{testpath} --file sample.py --line 1 --character 5 --format json",
    ))
    assert_equal "target", context["symbol"]
    assert_equal "complete", context["coverageStatus"]
    assert context["applicable"]
  end
end
