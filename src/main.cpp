#include "mesh3d.h"

/** @file main.cpp
 * 	@author [Alejandro Manzanares Lemus](https://github.com/Alexmnzlms)
 */

int main(int argc, char * argv[]) {

	srand (time(NULL));

	if(argc != 4){
		std::cout << "Wrong parameters" << std::endl;
		std::cout << "bin/panorama_extended [name] [relive route to 3D model]"
		<< " [relive route to image]"  << std::endl;
		exit(-1);
	}

	std::string name = argv[1];
	std::string path = argv[2];
	std::string path2 = argv[3];

	std::cout << "Loading " << name << "\tPath: " << path << "..." << std::endl;

	Mesh3D malla(name, path, true);

	if (malla.num_vertexs() > 0){
		std::cout << "Loaded " << malla.get_name() << std::endl;

		malla.color_3d_model(path2);

		malla.export_obj("models/214_izq_norm.obj", true);
	}
	return 0;
}