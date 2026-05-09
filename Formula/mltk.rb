class Mltk < Formula
  include Language::Python::Virtualenv

  desc "Pytest for ML — unified testing across the entire ML lifecycle"
  homepage "https://github.com/Liorrr/mltk"
  url "https://files.pythonhosted.org/packages/f0/1e/51a8ee37e46edac328bafc4d78c98b6f9c9bd95f9f7c4772c2b16ebb9fa5/mlspec-0.12.6.tar.gz"
  sha256 "7120af955b62f6613abc25348e20c943245fdc1e9175a8ebc481cee0c99ba569"
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
