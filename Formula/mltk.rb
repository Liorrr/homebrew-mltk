class Mltk < Formula
  desc "Pytest for ML — unified testing across the entire ML lifecycle"
  homepage "https://github.com/Liorrr/mltk"
  url "https://files.pythonhosted.org/packages/5f/6d/c0ebda30394f0a70c70f60ac42f8fb33f309a9bcb831a3ee9dda684ae6ce/mlspec-0.18.0.tar.gz"
  sha256 "3a68b646949c867a9f8a70ee678df01810e075ec133147438c3ecff5c4ff8b8e"
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
