load("//:bzl/library.bzl", "lib")
load(
    "@obazl_rules_ocaml//ocaml:rules.bzl",
    "ocaml_module",
    "ocaml_library",
    "ocaml_signature",
    "ppx_module",
    "ppx_library",
)

def generate_services_module(name, ext):
    native.genrule(
        name = "gen_" + name,
        srcs = ["services." + ext, "uri_services_raw.ml"],
        outs = [name + ".ml"],
        cmd = "$(location //config:exe) $(location services." + ext + ") > $@ && cat $(location uri_services_raw.ml) >> $@",
        tools = ["//config:exe"],
    )
    native.genrule(
        name = name + "_mli",
        srcs = [name + "_in.mli"],
        outs = [name + ".mli"],
        cmd = "cp $(location " + name + "_in.mli) $@",
    )

def services_lib(name, services_name):
    generate_services_module(services_name, name)
    lib(
        name = name,
        modules = [(services_name, "gen_" + services_name, services_name + "_sig", services_name + "_mli")],
        deps = ["//lib:lib-uri"],
    )
