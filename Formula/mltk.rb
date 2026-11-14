class Mltk < Formula
  desc "Pytest for ML — unified testing across the entire ML lifecycle"
  homepage "https://github.com/Liorrr/mltk"
  url "https://files.pythonhosted.org/packages/e2/24/a825fb8a49641500059f77b426cb32216c20f86ef3b43247d674b85e9789/mlspec-0.17.0.tar.gz"
  sha256 "4648ce8e2ca7a38efe7f980f082b881a8fbe9dae144645894bc59e6ad5ae6000"
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
