# -*- coding: utf-8 -*-
"""
Created on Mon Dec 11 12:13:58 2017

@author: Mohsen.B
"""
from scipy.io import loadmat
import numpy as np
import tensorflow as tf
from sklearn.preprocessing import scale
from keras.models import Sequential, load_model
from keras.layers import Dense, Dropout

# load models
models = []
for i in range(1, 18):
    print(i)
    models.append(load_model('model/model_'+str(i)+'.h5'))

# load datas
datas = []
for i in range(17):
    for j in range(3):
        for k in range(20):
            mat = loadmat('room1_data/LOC'+ str(i+1) +'/'+ str(j+1) +'_csi'+ str(k+1) +'.mat')
            InData = mat.get('csi')
            InDataR = np.array(InData).ravel()
            datas.append(InDataR)
            
# Feature Scaling            
from sklearn.preprocessing import MinMaxScaler
sc = MinMaxScaler(feature_range = (0, 1))
datas = np.abs(datas)
datas = sc.fit_transform(datas)
    
for i in range(17):
    for j in range(10):
        
        