{
  lib,
  buildPythonPackage,
  fetchPypi,
  markuppy,
  odfpy,
  openpyxl,
  pandas,
  pytestCheckHook,
  pytest-cov-stub,
  pythonOlder,
  pyyaml,
  setuptools-scm,
  tabulate,
  unicodecsv,
  xlrd,
  xlwt,
}:

buildPythonPackage rec {
  pname = "tablib";
  version = "3.8.0";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-lNi83GWnFaACSm1bcBpfMeRb0VkmnmLHNzHeefBI2ys=";
  };

  nativeBuildInputs = [ setuptools-scm ];

  optional-dependencies = {
    all = [
      markuppy
      odfpy
      openpyxl
      pandas
      pyyaml
      tabulate
      xlrd
      xlwt
    ];
    cli = [ tabulate ];
    html = [ markuppy ];
    ods = [ odfpy ];
    pandas = [ pandas ];
    xls = [
      xlrd
      xlwt
    ];
    xlsx = [ openpyxl ];
    yaml = [ pyyaml ];
  };

  nativeCheckInputs = [
    pandas
    pytestCheckHook
    pytest-cov-stub
    unicodecsv
  ];

  disabledTestPaths = [
    # test_tablib needs MarkupPy, which isn't packaged yet
    "tests/test_tablib.py"
  ];

  pythonImportsCheck = [ "tablib" ];

  meta = with lib; {
    description = "Format-agnostic tabular dataset library";
    homepage = "https://tablib.readthedocs.io/";
    changelog = "https://github.com/jazzband/tablib/raw/v${version}/HISTORY.md";
    license = licenses.mit;
    maintainers = [ ];
  };
}
