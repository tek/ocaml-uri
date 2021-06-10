load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def uri_deps():
    maybe(
        http_archive,
        "obazl_rules_ocaml",
        strip_prefix = "rules_ocaml-c7c0b864e91c1e248d2b0f07bcd4e5265f0c042d",
        urls = [
            "https://github.com/tek/rules_ocaml/archive/c7c0b864e91c1e248d2b0f07bcd4e5265f0c042d.tar.gz"
        ],
        sha256 = "66834f7cf2eabdf86258d4fb0ff07b56fedf9c430149dd3b3e528767e12c1fe1",
    )
