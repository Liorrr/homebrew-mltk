class Mltk < Formula
  include Language::Python::Virtualenv

  desc "Pytest for ML — unified testing across the entire ML lifecycle"
  homepage "https://github.com/Liorrr/mltk"
  url "https://files.pythonhosted.org/packages/b2/5d/1459090e9f35c4abd9a9e95c3cab5538b7dea32055e9d96f7e034c2d74dc/mlspec-0.13.0.tar.gz"
  sha256 "89eb84848632fa90086de85f32f249564fa9fec1781db9b54ca904d256b2304b"
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
