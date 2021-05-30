cp /home/juan.vallado/src/VisTR_modifications/inference.py /workspace/vistr/.
python /home/juan.vallado/src/utils/data_preparation.py
python /workspace/vistr/inference.py --masks --model_path ~/data/vistr_r50.pth --save_path /home/juan.vallado/output/out.json --eval
