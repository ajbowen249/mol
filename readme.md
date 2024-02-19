# Mol

![demo](/gh_media/demo_1.gif)

Mol is a Baldur's Gate 3 Demake for the Tandy TRS-80 Model 100, built on the [Dungeon Delver Engine](https://github.com/ajbowen249/dungeon-delver-engine).

## Legal Musings
Mol should be seen as a piece of "interactive fanart." Other recent demake projects have been taken down, but I believe this should be fine for the following reasons:
- It's not a paid product.
- It will never be even remotely close to a 1-1 representation of its inspiration, and playing it will not be a satisfying substitute for the original experience.
    - To that end, I intend to keep the overall tone a little lighter and partially based on memory. If it makes it far enough into development, it may even border on parody.
- It does not require circumvention of any security features to run on the platform.
- It's on a niche platform with a long-defunct parent company.

For now, this is the flagship project driving further development of `DDE`. In the event this does get taken down (despite my _ironclad_ reasoning above), that library should be unaffected, as, on its own, it's a valid OGL-SRD 5.1 use case. All references to WotC/Larian IP and other SRD no-nos are contained to this repository. I've got a few ideas on where I could take `DDE` if this gets Lamberted, like more-advanced `80` family machines or an original campaign.

As a final shameless plug, if this _does_ get the attention of the right companies to issue a cease-and-desist in the first place, expect my immediate cooperation... and, I'm open for employment 😉

## Building

This project uses [zasm](https://k1.spdns.de/Develop/Projects/zasm/Documentation/index.html) and [make](https://www.gnu.org/software/make/manual/make.html), and assumes `zasm` is in your `PATH`. First, pull down the engine with `git submodule update --init`, and then build with `make`. The campaign is split up into acts, and each act should yield a `bg3<act>.hex` file under `build`. Currently, only the first act exists.

## Running

### Physical Model 100

The `dungeon-delver-engine` repo has a two-step process with a loader script followed by a native loader program. Refer to the `dungeon-delver-engine` docs for that process.

### Virtual-T

Using the [Virtual-T](https://sourceforge.net/projects/virtualt/) emulator, first run `clear 256,49152`. Then, using the `Memory Editor` tool, load the output hex file starting at address `$C000`.

#### Once Loaded

Once the binary is loaded into memory through any method, you can run it with `call 49152`.
