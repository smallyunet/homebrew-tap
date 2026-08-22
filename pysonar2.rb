# typed: strict
# frozen_string_literal: true

# Homebrew formula for the platform-independent PySonar2 semantic CLI.
class Pysonar2 < Formula
  desc "Whole-project semantic analysis engine for Python"
  homepage "https://github.com/smallyunet/pysonar2"
  url "https://github.com/smallyunet/pysonar2/releases/download/v3.4.0/pysonar-cli-3.4.0.zip"
  sha256 "217dc27fb5c1f01e5cabaab5d1c6c16c157c2d8475ae80b22a0036f4f55a4142"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "openjdk"
  depends_on "python@3.13"

  def install
    libexec.install "lib/pysonar.jar"

    java = formula_opt_bin("openjdk")/"java"
    python = formula_opt_bin("python@3.13")/"python3.13"
    (bin/"pysonar").write <<~SH
      #!/bin/sh
      export PYSONAR_PYTHON="#{python}"
      exec "#{java}" -jar "#{libexec}/pysonar.jar" "$@"
    SH
    chmod 0755, bin/"pysonar"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pysonar --version").strip

    doctor = JSON.parse(shell_output("#{bin}/pysonar doctor --format json"))
    assert_equal "ok", doctor["status"]
    assert_match(/^Python 3\.13\./, doctor.dig("python", "version"))

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
