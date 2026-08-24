# typed: strict
# frozen_string_literal: true

# Homebrew formula for the native PySonar2 type-inference CLI and language server.
class Pysonar2 < Formula
  desc "Whole-project type inferencer and semantic indexer for Python"
  homepage "https://github.com/smallyunet/pysonar2"
  url "https://github.com/smallyunet/pysonar2/releases/download/v4.1.0/pysonar2-v4.1.0-x86_64-unknown-linux-gnu.tar.gz"
  sha256 "1d215078c454c24d7bebea6fe315cb0557f53b16786333b687f721983595c0b0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/smallyunet/pysonar2/releases/download/v4.1.0/pysonar2-v4.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "7557d5d12fb64838e25750d3b7990d2c96c5a90be5b6487b22042e36b3946bb7"
    else
      url "https://github.com/smallyunet/pysonar2/releases/download/v4.1.0/pysonar2-v4.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "53a8c7b812c584ac672192bb35f89361e63373cde503511be8399e54aacf6886"
    end
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
    command = "#{bin}/pysonar context --root #{testpath} --file sample.py " \
              "--line 1 --character 5 --format json"
    context = JSON.parse(shell_output(command))
    assert_equal "target", context["symbol"]
    assert_equal "complete", context["coverageStatus"]
    assert context["applicable"]
  end
end
