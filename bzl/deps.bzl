load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def uri_deps():
    maybe(
        http_archive,
        "obazl_rules_ocaml",
        strip_prefix = "rules_ocaml-f29aea71b24049c7c3cf1ee7c4645f4276963208",
        urls = [
            "https://github.com/tek/rules_ocaml/archive/f29aea71b24049c7c3cf1ee7c4645f4276963208.tar.gz"
        ],
        sha256 = "293590351a8b5ebb37f314b73333f289bb467acb2b4ecc825f6300dcc0783278",
    )
