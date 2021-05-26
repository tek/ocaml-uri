load(
    "@obazl_rules_ocaml//ocaml:rules.bzl",
    "ocaml_module",
    "ocaml_library",
    "ocaml_signature",
    "ppx_module",
    "ppx_library",
)

def sig(name, **kw):
    ocaml_signature(
        name = "{}_sig".format(name),
        src = "{}.mli".format(name),
        **kw,
    )

def lib(modules, name="lib", deps_opam=[], deps=[], ppx=False, **kw):
    module = ppx_module if ppx else ocaml_module
    library = ppx_library if ppx else ocaml_library
    for (mod_name, mod) in modules:
        sig(mod_name, deps_opam = deps_opam, deps = deps)
        module(
            name = mod_name,
            struct = mod,
            sig = "{}_sig".format(mod_name),
            deps_opam = deps_opam,
            deps = deps,
        )
    modules = [n for (n, m) in modules]
    library(
        name = name,
        modules = modules,
        visibility = ["//visibility:public"],
        **kw,
    )

def simple_lib(modules, **kw):
    targets = [(m, m + ".ml") for m in modules]
    return lib(targets, **kw)
