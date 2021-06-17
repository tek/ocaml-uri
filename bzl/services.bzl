load("@obazl_rules_ocaml//dsl:library.bzl", "copy_interface", "lib", "sig")

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
        modules = {
            services_name: sig(mod_src = ":gen_" + services_name, sig_src = services_name + "_mli"),
        },
        deps = ["//lib:#Uri"],
    )
