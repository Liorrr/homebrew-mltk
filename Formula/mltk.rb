class Mltk < Formula
  desc "Pytest for ML — unified testing across the entire ML lifecycle"
  homepage "https://github.com/Liorrr/mltk"
  url "https://files.pythonhosted.org/packages/8b/df/ff5fab72b59e5adfd4c6ba76de1bfb96b1027b07625f6cfb3e720c9f59bd/mlspec-0.17.1.tar.gz"
  sha256 "9a42722349c2018c3fe6f397cc6538a2c3ebf65fabda3de18930bc9bf53f0a52"
  license "Elastic-2.0"

  depends_on "rust" => :build
  depends_on "python@3.13"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # Homebrew's venv.pip_install runs pip with --no-deps, and no runtime
    # dependency is declared as a resource, so it installed mlspec without
    # numpy, pandas, typer or rich. Let pip resolve them from PyPI instead.
    system formula_opt_bin("python@3.13")/"python3.13", "-m", "venv", libexec
    system libexec/"bin/python", "-m", "pip", "install", "#{buildpath}[cli]"
    bin.write_exec_script libexec/"bin/mltk"
  end

  def caveats
    <<~EOS
      mltk is currently published on PyPI as 'mlspec' while the 'mltk' PyPI name transfer is pending.
      For pip installs use: pip install mlspec
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mltk version")
  end
end
