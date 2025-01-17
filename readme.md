# Mol
Mol is a Baldur's Gate 3 "Demake" for the Tandy TRS-80 Model 100 and ZX Spectrum, built on my [Dungeon Delver Engine](https://github.com/ajbowen249/dungeon-delver-engine). Feel free to use it for your own game and use this project for reference!

Demo and Making Of:

[![making of video](https://img.youtube.com/vi/zW9-hpuNDQQ/0.jpg)](http://www.youtube.com/watch?v=zW9-hpuNDQQ)

![demo](/gh_media/nere_battle.gif)
![demo](/gh_media/demo_1.gif)
![demo](/gh_media/goblin_camp.gif)
![demo](/gh_media/recruit_demo.gif)
![demo](/gh_media/zhalk_battle.gif)
![demo](/gh_media/zx_spectrum_demo.gif)

## Legal Musings
Mol should be seen as a piece of "interactive fanart." Other recent demake projects have been taken down, but I believe this should be fine for the following reasons:
- It's not a paid product.
- It will never be even remotely close to a 1-1 representation of its inspiration, and playing it will not be a satisfying substitute for the original experience.
    - To that end, I intend to keep the overall tone a little lighter and partially based on memory. If it makes it far enough into development, it may even border on parody.
- It does not require circumvention of any security features to run on the platform.
- It's on a niche platform with a long-defunct parent company.

For now, this is the flagship project driving further development of `DDE`. In the event this does get taken down (despite my _ironclad_ reasoning above), that library should be unaffected, as, on its own, it's a valid OGL-SRD 5.1 use case. All references to WotC/Larian IP and other SRD no-nos are contained to this repository. I've got a few ideas on where I could take `DDE` if this gets Lamberted, like more-advanced `80` family machines or an original campaign.

## Running

### TRS-80 Model 100

The [Releases](https://github.com/ajbowen249/mol/releases) page should have the latest build of the project. You should see both `.co` and `.hex` files for each act (currently just act 1).

#### From Cassette

Thanks to [majick](https://github.com/majick), the build script produces a `.co`-formatted file binary file. This file is too large to work in the Model 100's built-in storage, but can be loaded up through the cassette interface. This is currently only confirmed working on [CloudT](https://bitchin100.com/CloudT/#!/M100Display), but should, theoretically, work on a stock Model 100 when loaded through the cassette interface as well. To run it on CloudT:

1. Enter BASIC, and run `clear 256,43776`
2. Click "Choose File," and select `bg31.co`
3. Run `cloadm`
4. When it's done loading, run `call 43776`

#### Physical Model 100/102 From Disk or TPDD Emulation

The `.co` binary can be loaded into memory via disk, on physical hardware. The easiest method is to use an emulated TPDD, such as [dl2/dlplus](https://github.com/bkw777/dl2) or [LaddieAlpha](http://bitchin100.com/wiki/index.php?title=LaddieCon#LaddieAlpha), with TS-DOS in ROM or with some other small DOS bootstrapped via `dl`

Assuming TS-DOS, since that's the most common:
1. Enter TS-DOS and press `F5` to enable DOS-ON mode
2. Exit to MENU
3. Enter BASIC and run `CLEAR 256, 43776`
4. Run `LOADM "0:bg31.co"`
5. When it's done loading, run `CALL 43776`

This method has been tested to work on physical hardware.

#### Physical Model 100 with Just a Serial Cable

If all you have is a stock Model 100 and a serial cable to connect to a modern PC, then the `dungeon-delver-engine` repo has a two-step process with a loader script followed by a native loader program that can help you out. Refer to the `dungeon-delver-engine` docs for that process.

#### Virtual-T

Using the [Virtual-T](https://sourceforge.net/projects/virtualt/) emulator, first run `clear 256,43776`. Then, using the `Memory Editor` tool, load the output `.hex` file starting at address `$AB00`. Once that is done, you can run it with `call 43776`.

### ZX Spectrum

The [Releases](https://github.com/ajbowen249/mol/releases) page should have the latest build of the project. You should a `.tap` file for each act (currently just act 1). With the tape ready, the game can be loaded and run with `LOAD ""`. This has so far only been verified via the [`Fuze`](https://fuse-emulator.sourceforge.net/) emulator set to the `Spectrum 48k` ROM, and has not been verified on physical hardware.

## Controls

On all platforms, both arrow keys and `WASD` are supported for movement and navigating menus. `ENTER` is used to select menu options and interact with interactables. On the Model 100, the `ESC` key can be used to bring up the menu and cancel combat attacks and casting. That key is `DELETE` (backspace) for the ZX Spectrum.

## Building

### Basics
This project requires [`zasm`](https://k1.spdns.de/Develop/Projects/zasm/Documentation/index.html) and [`python 3`](https://www.python.org/). It also requires the `dungeon-delver-engine` submodule to be present, which you can get with `git submodule update --init`.

The build system is [`waf`](https://waf.io/), which itself is built on Python, and the `waf` "executable" is versioned alongside this project. To use `waf`, you can invoke it with `./waf` on *nix platforms, or use `./waf.bat` on Windows. It's recommended, especially if you use other `waf` projects, to set up an alias to make invocation simpler (such as `alias waf=./waf`).

When you first check the project out (or after pulling down updates), you'll first want to run `waf configure`, which will set up some paths and ensure it can find `zasm`. This step will fail if `zasm` is not in your `PATH`, or if your python version is below 3.

After that, simply run `waf` to build all outputs and run unit tests. You'll usually only need to run `waf configure` after changes to the build script, or to make changes to your selected options.

### ZX Spectrum (Experimental)

The ZX Spectrum build is currently disabled by default until stabilized. To enable it, pass `zx_spectrum` to `waf configure`'s `--platform` option. You can supply it on its own, or with both platforms:

```shell
# Spectrum on its own
waf configure --platforms=zx_spectrum
# Spectrum and Model 100
waf configure --platforms=trs80_m100,zx_spectrum
```

When you select the `zx_spectrum` platform, `waf configure` will also ensure you have [`bin2tap`](https://sourceforge.net/p/zxspectrumutils/wiki/bin2tap/) (from [`zxspectrum-utils`](https://sourceforge.net/projects/zxspectrumutils/)) available in your path. This is required to package the raw binary output from `zasm` into a tape format with a `BASIC` bootloader.

> **Note:** The reason this is disabled by default is that the build will currently fail on the first pass when calling `bin2tap`. Simply invoking `waf` multiple times _does_ eventually produce a working `tap` file.
