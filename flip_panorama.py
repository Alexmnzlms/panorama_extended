import cv2 as cv
import argparse
import os

def main(panorama_folder, output_folder):
    for root, dirs, files in os.walk(panorama_folder):
        for file in files:
            basename, ext = os.path.splitext(file)
            if ext in [".png"]:
                print("Processing {}...".format(basename))
                img_orig = cv.imread(os.path.join(root, file))
                h, w, d = img_orig.shape

                breakpoint = [int(w/3), int(2*w/3)]

                img = img_orig[:,:breakpoint[1]]
                img = cv.flip(img, 1)

                img_orig[:,:breakpoint[1]] = img

                img_orig[:,breakpoint[1]:] = img[:,:breakpoint[0]]

                output_file_dir = os.path.basename(os.path.dirname(os.path.join(root, file)))
                output_file = os.path.join(output_folder,output_file_dir,file)

                # print(os.path.join(root, file))
                # print(output_file_dir)
                # print(output_file)

                if not os.path.exists(os.path.join(output_folder,output_file_dir)):
                    os.makedirs(os.path.join(output_folder,output_file_dir))

                cv.imwrite(output_file, img_orig)


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    
    parser.add_argument(
        "-f",
        "--folder",
        help = "",
        type = str,
        required = True
    )

    parser.add_argument(
        "-o",
        "--output_folder",
        help = "",
        type = str,
        required = True
    )

    args = parser.parse_args()

    if not os.path.exists(args.output_folder):
        os.makedirs(args.output_folder)

    main(args.folder, args.output_folder)