class Mltk < Formula
  desc "Pytest for ML — unified testing across the entire ML lifecycle"
  homepage "https://github.com/Liorrr/mltk"
  url "https://files.pythonhosted.org/packages/70/94/0d718d1b971cfef2dd2e47345008956e8fae754e4f75f9ee1f9c3e326cf9/mlspec-0.15.0.tar.gz"
  sha256 "582abfdaab08219cbb0b0a5328b37bbf5b098a3fa29ed4f9e554d96a395e70af"
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
