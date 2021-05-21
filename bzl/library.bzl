load(
    "@obazl_rules_ocaml//ocaml:rules.bzl",
    "ocaml_module",
    "ocaml_library",
    "ocaml_signature",
    "ppx_module",
    "ppx_library",
)

def uri_sig(name, deps_opam=[], deps=[]):
    ocaml_signature(
        name = "{}_sig".format(name),
        src = "{}.mli".format(name),
        deps_opam = deps_opam,
        deps = deps,
    )

def uri_library(modules, deps_opam=[], deps=[], ppx=False):
    module = ppx_module if ppx else ocaml_module
    library = ppx_library if ppx else ocaml_library
    for name in modules:
        ocaml_signature(
            name = "{}_sig".format(name),
            src = "{}.mli".format(name),
            deps_opam = deps_opam,
            deps = deps,
        )

        module(
            name = name,
            struct = "{}.ml".format(name),
            sig = "{}_sig".format(name),
            deps_opam = deps_opam,
            deps = deps,
        )

    library(
        name = "lib",
        modules = modules,
        visibility = ["//visibility:public"],
    )
