load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def uri_deps():
    maybe(
        http_archive,
        "obazl_rules_ocaml",
        strip_prefix = "rules_ocaml-58767d453d733d2a92b6c82589732f9b412b0af9",
        urls = [
            "https://github.com/tek/rules_ocaml/archive/58767d453d733d2a92b6c82589732f9b412b0af9.tar.gz"
        ],
        sha256 = "63483ef8c0673126a77fa9537769c6dec11f4e1b33bf8de43424ce1ecbcde8c2",
    )
