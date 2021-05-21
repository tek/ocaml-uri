FROM ocaml/opam:ubuntu-20.10-ocaml-4.12
USER root
RUN apt-get update
RUN apt-get install -y apt-utils g++ zlib1g-dev bash-completion unzip python patch zip git build-essential libtinfo5 software-properties-common
RUN add-apt-repository universe
RUN apt-get install -y pkg-config
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN curl -LO "https://github.com/bazelbuild/bazel/releases/download/4.0.0/bazel_4.0.0-linux-x86_64.deb" && dpkg -i bazel_*.deb
USER opam
RUN opam install ocamlfind stringext angstrom
RUN opam install re
RUN opam install sexplib
RUN opam install ppx_sexp_conv
RUN opam install ppx_deriving
