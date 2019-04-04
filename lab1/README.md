# Lab 1

## Compile
```
#!/bin/bash

tar=$1
len=$(echo $tar | wc -m)
iverilog -o $*
vvp $tar
gtkwave "$(echo $tar | cut -c1-$(($len - 3)))cd"
```
