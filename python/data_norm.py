# -*- coding: utf-8 -*-
"""
Created on Tue Dec 12 12:47:14 2017

@author: Mohsen.B
"""

from scipy.io import loadmat
import numpy as np
from sklearn.preprocessing import Normalizer
from sklearn.externals import joblib

# data loading
for i in range(17):
    for j in range(3):
        for k in range(20):
            mat = loadmat('room1_data/LOC'+ str(i+1) +'/'+ str(j+1) +'_csi'+ str(k+1) +'.mat')
            InData = mat.get('csi')
            InDataR = np.array(InData).ravel()
            if i == 0 and j == 0 and k == 0:
                x = InDataR
                y = i+1;
            else :
                x = np.vstack([x, InDataR])
                y = np.vstack([y, i+1])
                
# Feature Scaling
x = np.abs(x)
normalizer = Normalizer().fit(x)

# Store normalizer object
joblib.dump(normalizer, 'stored_obj/normalizer.pkl')

# Load normalizer object
#normalizer = joblib.load('stored_obj/normalizer.pkl')