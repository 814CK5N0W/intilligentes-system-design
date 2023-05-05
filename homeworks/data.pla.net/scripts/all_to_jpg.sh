#!/bin/bash
for i in *.png; do sips -s format jpeg $i --out Converted/$i.jpeg