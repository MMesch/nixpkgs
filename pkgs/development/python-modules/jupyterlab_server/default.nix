{ lib, buildPythonPackage, fetchPypi, jsonschema, notebook, pythonOlder }:
buildPythonPackage rec {
  pname = "jupyterlab_server";
  version = "0.2.0";
  disabled = pythonOlder "3.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "72d916a73957a880cdb885def6d8664a6d1b2760ef5dca5ad665aa1e8d1bb783";
  };

  propagatedBuildInputs = [
    jsonschema
    notebook
  ];

  # depends on requests and a bunch of other libraries
  doCheck = false;

  meta = with lib; {
    description = "This package is used to launch an application built using JupyterLab";
    license = with licenses; [ bsd3 ];
    homepage = "http://jupyter.org/";
    maintainers = with maintainers; [ zimbatm ];
  };
}
