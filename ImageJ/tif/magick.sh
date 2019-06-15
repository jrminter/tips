#!/bin/bash
magick convert R.tif G.tif B.tif IR.tif -channel RGBA -combine magick.tif
