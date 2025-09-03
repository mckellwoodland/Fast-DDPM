from PIL import Image
from torch.utils.data import Dataset
import glob

from .sr_util import get_paths_from_npys, brats_transform_augment


class LIVER_CT(Dataset):
    def __init__(self, dataroot, img_size, split='train'):
        self.img_size = img_size
        self.split = split
        self.img_pths = glob.glob(dataroot + "*.png", recursive=True)
        self.data_len = len(self.img_pths)
        
    def __len__(self):
        return self.data_len

    def __getitem__(self, index):
        base_name = self.img_pths[index].split('/')[-1]
        case_name = base_name.split('.')[0]
        
        img = Image.open(self.img_pths[index]).convert("L")
        img = img.resize((self.img_size, self.img_size))
        
        [img] = transform_augment([img], split=self.split)

        return {'FD': img, 'LD': img, 'case_name': case_name}
