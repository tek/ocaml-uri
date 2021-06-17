{
  description = "OCaml: uri";

  inputs.obazl.url = github:tek/rules_ocaml;

  outputs = { obazl, ... }:
  let
    extraInputs = p: [
    ];

    depsOpam = [
      "angstrom"
      "crowbar"
      "fmt"
      "ounit"
      "ppx_deriving"
      "ppx_sexp_conv"
      "ppxlib"
      "re"
      "sexplib"
      "sexplib0"
      "stringext"
    ];

  in obazl.flakes { inherit extraInputs depsOpam; };
}
