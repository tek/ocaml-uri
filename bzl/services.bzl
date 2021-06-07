load("//:bzl/library.bzl", "copy_interface", "lib")

def generate_services_module(name, ext):
    native.genrule(
        name = "gen_" + name,
        srcs = ["services." + ext, "uri_services_raw.ml"],
        outs = ["__obazl/" + name + ".ml"],
        cmd = "$(execpath //config:exe) $(execpath services." + ext + ") > $@ && cat $(execpath uri_services_raw.ml) >> $@",
        tools = ["//config:exe"],
    )
    copy_interface(name, name)

def services_lib(name, services_name):
    generate_services_module(services_name, name)
    lib(
        name = "services_" + name,
        modules = [(services_name, "gen_" + services_name, services_name + "_sig", services_name + "_mli")],
        deps = ["//lib:lib-uri"],
    )
