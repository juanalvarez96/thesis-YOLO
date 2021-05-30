import os
import json
import pdb

class AnnotationGenerator(object):
    def __init__(self, sequences_folder, out_folder, width, height):
        self.sequences_folder = os.path.abspath(sequences_folder)
        self.out_folder = os.path.abspath(out_folder)
        self.width = width
        self.height = height

    
    def generate_json(self):
        basepath=self.sequences_folder
        videos = [dict() for x in range(len(os.listdir(basepath))+1)]
        file_names=[]
        id = 1
    # pdb.set_trace()
        for folder in os.listdir(basepath):
            dir_path = os.path.join(basepath, folder)
            for entry in os.listdir(dir_path):
                file_names.append(os.path.join(dir_path, entry))
            videos[id]['file_names']=file_names
            videos[id]['id']=id
            videos[id]['height']=self.height
            videos[id]['width']=self.width
            videos[id]['length']=len(file_names)
            id = id +1
            file_names = []
        del videos[0]
        data = {
            'meta':{
                'name':'annotation_vis_val',
                'category_labels':{'1':'bird'},
                'version':'0.1'
            },
            'videos': videos
            }
        
        with open(self.out_folder, 'w') as fp:
                json.dump(data, fp)
        