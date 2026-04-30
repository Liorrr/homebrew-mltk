class Mltk < Formula
  include Language::Python::Virtualenv

  desc "Pytest for ML — unified testing across the entire ML lifecycle"
  homepage "https://github.com/Liorrr/mltk"
  url "https://github.com/Liorrr/mltk/archive/refs/tags/v0.12.5.tar.gz"
  sha256 "945516ffa437ec691bffb84832f50b08bd6c4c1117821968a0bc2d1ed15a3439"
  license "Elastic-2.0"

  depends_on "rust" => :build
  depends_on "python@3.13"

  def install
    venv = virtualenv_create(libexec, "python3.13")
    venv.pip_install buildpath
    bin.write_exec_script libexec/"bin/mltk"
  end

  def caveats
    <<~EOS
      mltk is currently published on PyPI as 'mlspec' while the 'mltk' PyPI name transfer is pending.
      For pip installs use: pip install mlspec
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mltk --version")
  end
end
