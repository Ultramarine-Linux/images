# Ultramarine Linux
Ultramarine Linux is a remix of the Fedora Linux distribution focused on experimenting with niche (and sometimes unconventional) desktop configurations.

It is built on top of the standard Fedora images with custom Kickstart configurations.

# Instructions 
Simply download the ISO and install, and you should be ready to go! or:
## Building Instructions
Simply clone the this repository and run these scripts in order, and make sure you have at least 10GB of space to accommodate for the temporary build files.

Download the dependencies (If you don't have Lorax and Anaconda installed)
```
./builddeps.sh
```

Build a Lorax base install Image (For first build only, or if you want to provide an already existing Fedora image, skip this step)
```
./build-lorax.sh <release> <architecture>
```

And finally, build the actual image.
```
./build.sh <path to kickstart config> <project name(for GRUB)> <filesystem label for ISO>
```

# Frequently Asked Questions
## What is this repo?
This is a collection of scripts for creating your own build of Ultramarine, as Ultramarine is just a set of Kickstart scripts to Remix a standard Fedora installation.
## What is Kickstart?
Red Hat Kickstart is a scripting format for the Anaconda installer to perform custom unattended installations. It can also be scripted in a way to create a bootable live installer too!
## What software is included in Ultramarine?
The software suites preinstalled in Ultramarine will be the same as any other Fedora install, except for some changed defaults depending on the spin.
## Why did you name this Ultramarine? Why not Fedora XYZ spin?
Due to the [trademark policy](https://fedoraproject.org/wiki/Legal:Trademark_guidelines#Distributing_combinations_of_Fedora_software_with_non-Fedora_or_modified_Fedora_software) from Fedora, we cannot legally use their trademark in any modified copy of Fedora. 

The name "Ultramarine" is inspired from the "blueness" of the Fedora Project and is meant to be a polar opposite to Silverblue, Unstable, experimental and very niche.
## `foo` SUCKS!!! WHY DID YOU NOT USE `bar`!?!?!? YOUR DISTRO IS BAD!
If you think that we should change something, submit an issue explaining why and we'll consider it. Even better, make the fix yourself and submit a pull request so we can integrate it directly into the code. And please, be civil about it. 
## What's the update scheme?
We directly pull packages from the latest Fedora release builds,  But this can be configured manually to use other releases, including Rawhide.
# Disclaimer and legal jargon
This project is **NOT** in any way related with the Fedora Project, Red Hat, or IBM. And as mentioned in the [LICENSE](https://github.com/ultramarine-linux/ultramarine-kickstarts/blob/dabffd92dc18265764e6bd6ff3a3bc11cbab6461/LICENSE), We are **NOT** responsible for lost productivity or any damage to your data or infrastructure from the use of our software. You have been warned.

This project can be used as an unofficial staging repo for new and upcoming Fedora SIGs, and if a certain configuration has been accepted as a new spin, we will deprecate our spin as such and development should be continued there.

# Even bigger Disclaimer
This might be a bit redundant but, This is not an official Fedora build. If you're looking for the mainline rolling release version, please refer to [Rawhide](https://fedoraproject.org/wiki/Releases/Rawhide).
If you're looking for the standard mainline releases of Fedora with a more conventional environment, or a spin that has recently been deprecated from this, [please get the official Fedora builds here](https://getfedora.org/).