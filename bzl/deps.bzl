load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def uri_deps():
    maybe(
        http_archive,
        "obazl_rules_ocaml",
        strip_prefix = "rules_ocaml-6cfa9f4a87b4b31653dd17655668ffe86588951f",
        urls = [
            "https://github.com/tek/rules_ocaml/archive/6cfa9f4a87b4b31653dd17655668ffe86588951f.tar.gz",
        ],
        sha256 = "975eaa0158536a69f791aec7e8781f0f7001883d67f0742c28cd4cbf9df41386",
    )
