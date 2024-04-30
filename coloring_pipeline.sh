#!/bin/sh
make

python generate_colored_models.py -i ../../Age_estimation_from_3D_models/mapas_de_activacion/relevance_maps.csv -o $1

python src/join_colored.py -f $1/Resnet &
python src/join_colored.py -f $1/Panorama &

wait
