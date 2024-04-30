#!/bin/bash

make -B

for muestra in 15 115 141 195 210 214 265 313 505 507 558; do
    for red in resnet panorama_cnn; do
        mkdir -p models/colored/$red/$muestra
       bin/panorama_extended $muestra ../pubis/$muestra/Izq/Izq.obj ../relevance_maps/heatmap/$red/$muestra/heatmap_img_data_${muestra}_izq.png ../relevance_maps/heatmap/$red/$muestra/heatmap_img_data_${muestra}_dch.png models/colored/$red/$muestra
    done
done