import torch
import torch.nn as nn
import torchvision
from torchvision import transforms, datasets
import os
import numpy as np
import ssl
use_cuda = torch.cuda.is_available()
ssl._create_default_https_context = ssl._create_unverified_context

recyclingNet = torchvision.models.mobilenet_v2(pretrained=True)
recyclingNet.classifier[1] = torch.nn.Linear(1280, 6)

if use_cuda:
  recyclingNet = recyclingNet.cuda()

for param in recyclingNet.features.parameters():
    param.requires_grad = False


data_dir = './trash_data/Garbage classification/Garbage classification'

transform = transforms.Compose([transforms.Resize(225), transforms.ToTensor(), transforms.Normalize(mean = [0.485, 0.456, 0.406], std = [0.229, 0.224, 0.225])])


data = datasets.ImageFolder(data_dir, transform=transform)

data_loader = torch.utils.data.DataLoader(data, batch_size=30, num_workers=0, shuffle=True )

if use_cuda:
    criterion = nn.CrossEntropyLoss().cuda()
else:
    criterion = nn.CrossEntropyLoss()

optimizer = torch.optim.SGD(recyclingNet.parameters(), lr=.003, momentum=0.9)

def train(epochs, loader, model, optimize, criter, use_cuda, save_path):

  min_loss = np.Inf

  for ii in range(1, epochs+1):
    current_loss = 0

    for batch_idx, (data, target) in enumerate(data_loader):
      if use_cuda:
          data, target = data.cuda(), target.cuda()
      optimize.zero_grad()
      output = model(data)
      loss = criter(output, target)
      loss.backward()
      optimize.step()

      current_loss = current_loss + ((1 / (batch_idx + 1)) * (loss.data - current_loss))
      print("\nEpoch: " + str(ii) + " Loss: " + str(float(loss)))



      if min_loss > current_loss:
        print("Loss went from " + str(float(min_loss)) + " -> " + str(float(current_loss)) + " Saving ...")
        min_loss = current_loss
        torch.save(model.state_dict(), save_path)


train(10, data_loader, recyclingNet, optimizer, criterion, use_cuda, "./recycling_net.pt")
