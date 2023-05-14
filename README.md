# DeepFusion-SymEngine
The patches for the customized `SymEngine` needed for DeepFusion. 

# How to

## Patch and Build
Lets assume the release tag without 'v' of `0.10.1` should be patched and built. 
```bash
sh apply_and_build.sh 0.10.1
```
This scripts will:
1. Download the release `*.tar.gz` [from `SymEngine`'s Github repository](https://github.com/symengine/symengine/releases).
2. Extract it.
3. Configure it with `cmake`.
4. Build it with `make -j`

Then you have to install the build `SymEngine` manually.

## Modify the original sources from scratch
First run:
```bash
sh dev_prepare.sh 0.10.1
```
Then modify the code base at `workdir/symengine-0.10.1`.
Make sure you are **NOT** editing the code at `workdir/*-patched`.

Finally, run this command to get the `*.diff` file.
```bash
sh dev_diff.sh workdir/symengine-0.10.1
```