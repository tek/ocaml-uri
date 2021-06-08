load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def uri_dependencies():
    maybe(
        http_archive,
        "obazl_rules_ocaml",
        strip_prefix = "rules_ocaml-a9f16f7267bc97f7d68e9593565d2fee787b28fb",
        urls = [
            "https://github.com/tek/rules_ocaml/archive/a9f16f7267bc97f7d68e9593565d2fee787b28fb.tar.gz"
        ],
        sha256 = "ae8dede0facda7b7915097c382c70e853c6563b793ead2220d703572a2be2b95",
    )
