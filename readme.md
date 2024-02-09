# Mol

![demo](/gh_media/environment_demo.gif)

Mol is a Baldur's Gate 3 Demake for the Tandy TRS-80 Model 100, built on the [Dungeon Delver Engine](https://github.com/ajbowen249/dungeon-delver-engine).

## Building

This project uses [zasm](https://k1.spdns.de/Develop/Projects/zasm/Documentation/index.html) and [make](https://www.gnu.org/software/make/manual/make.html), and assumes `zasm` is in your `PATH`. First, pull down the engine with `git submodule update --init`, and then build with `make`. The campaign is split up into acts, and each act should yield a `bg3<act>.hex` file under `build`.
