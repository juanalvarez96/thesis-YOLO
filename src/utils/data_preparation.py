from annotationGenerator import AnnotationGenerator
from argparse import ArgumentParser
import os
import pdb

sequences_folder = '/home/juan.vallado/data/DAVIS/JPEGImages/480p'
annotations_file = '/workspace/annotation/annotations_vis_val.json'
width = 854
height = 480

def main():
    annotator = AnnotationGenerator(sequences_folder, annotations_file, width, height)
    annotator.generate_json()

    






if __name__ == '__main__':
    main()

