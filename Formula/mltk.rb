class Mltk < Formula
  include Language::Python::Virtualenv

  desc "Pytest for ML — unified testing across the entire ML lifecycle"
  homepage "https://github.com/Liorrr/mltk"
  url "https://files.pythonhosted.org/packages/70/94/0d718d1b971cfef2dd2e47345008956e8fae754e4f75f9ee1f9c3e326cf9/mlspec-0.15.0.tar.gz"
  sha256 "582abfdaab08219cbb0b0a5328b37bbf5b098a3fa29ed4f9e554d96a395e70af"
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
