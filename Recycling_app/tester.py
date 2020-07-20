import torch
import torch.nn as nn
import torchvision
from torchvision import transforms, datasets
import os
import numpy as np
import ssl
import sys
from PIL import Image
from PIL import ImageFile
ImageFile.LOAD_TRUNCATED_IMAGES = True

use_cuda = torch.cuda.is_available()

data_dir = './trash_data/Garbage classification/Garbage classification'

transform = transforms.Compose([transforms.Resize(225), transforms.CenterCrop(224), transforms.ToTensor(),                                                    transforms.Normalize(mean = [0.485, 0.456, 0.406], std = [0.229, 0.224, 0.225])])

data = datasets.ImageFolder(data_dir, transform=transform)

recyclingNet = torchvision.models.mobilenet_v2(pretrained=True)
recyclingNet.classifier[1] = torch.nn.Linear(1280, 6)

recyclingNet.load_state_dict(torch.load('recycling_net.pt'))

recyclingNet.eval()
def get_prediction(img_path):
    img = Image.open(img_path)

    transformer = transforms.Compose([transforms.Resize(256), transforms.CenterCrop(224), transforms.ToTensor(),
                                      transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])])

    img = transformer(img)

    img = img.unsqueeze(0)
    ## Return the *index* of the predicted class for that image

    int_output = int(recyclingNet.forward(img).cpu().detach().numpy().argmax())


    classes = ["glass", "paper", "cardboard", "plastic", "metal", "trash", "error"]

    return (data.classes[int(int_output)])
counter = 0
type = sys.argv[1]
dict = {"cardboard": 403, "glass": 501, "metal": 410, "paper": 594, "plastic": 482, "trash": 137 }
for i in range(1, dict.get(type) + 1):
    """
    cb = 403
    g = 501
    metal = 410
    paper = 594
    plastic = 482
    trash = 137
    """
    prediction = get_prediction(".\\trash_data\Garbage classification\Garbage classification\\" + type + "\\" + type + str(i) + ".jpg")
    print (prediction)
    if prediction != type:
        counter += 1
print (str(counter/dict.get(type)))
