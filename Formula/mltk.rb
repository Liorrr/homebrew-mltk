class Mltk < Formula
  include Language::Python::Virtualenv

  desc "Pytest for ML — unified testing across the entire ML lifecycle"
  homepage "https://github.com/Liorrr/mltk"
  url "https://files.pythonhosted.org/packages/e7/13/8028e8221adb83d3fd6edaecb930b7864b348c5b48ca422cadd3265a3f6c/mlspec-0.14.0.tar.gz"
  sha256 "ba3a5f5dafa4135962c7d4e1e2363c7f21286cf5e0952cfe8c0bb1566bb78826"
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
