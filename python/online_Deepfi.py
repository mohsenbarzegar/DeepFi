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
from sklearn.preprocessing import Normalizer
from sklearn.externals import joblib

# Locations
loc = np.array([[0, 0], [0, 1.5], [0, 3], [0, 4.5], [0, 7], [1.5, 7], [1.5, 5.5],
                [1.5, 4.5], [1.5, 3], [1.5, 1.5], [4.5, 1.5], [4.5, 3], [4.5, 4.5]
                , [4.5, 5.5], [4.5, 7], [-1, 7], [-2, 7]])
# Load normalizer object
normalizer = joblib.load('stored_obj/normalizer.pkl')

# load models
models = []
for i in range(1, 18):
    models.append(load_model('model/model_'+str(i)+'.h5'))
    print('model ' + str(i) + ' loaded')

# load datas
datas = []
for i in range(17):
    for j in range(3):
        for k in range(20):
            mat = loadmat('room1_data/LOC'+ str(i+1) +'/'+ str(j+1) +'_csi'+ str(k+1) +'.mat')
            InData = mat.get('csi')
            InDataR = np.array(InData).ravel()
            if (j == 0 and k == 0):
                    x = InDataR
                    y = i+1;
            else :
                    x = np.vstack([x, InDataR])
                    y = np.vstack([y, i+1])
    datas.append(x)
    print('data ' + str(i) + ' loaded')
    
# Feature Scaling            
datas = np.abs(datas)
for i in range(17):
    datas[i,:,:] = normalizer.transform(datas[i,:,:])
   
result = []
for i in range(17):
    res = []
    for j in range(17):
        res_t = datas[i,:,:] - models[j].predict(datas[i,:,:])
        res_t = np.sum(res_t)
        if i == j:
            res_t = 1000
        res.append(res_t)
    result.append(res)

result = np.abs(result)

def calc_error(p1, c1, p2, c2, p_t):
    dis1 = loc[p_t] - loc[p1]
    dis2 = loc[p_t] - loc[p2]
    dis1 = np.sqrt(np.square(dis1[0]) + np.square(dis1[1]))
    dis2 = np.sqrt(np.square(dis2[0]) + np.square(dis2[1]))
    error = (dis1*c2 + dis2*c1)/(c1+c2)
    return error

err = []
for i in range(17):
    index =  result[:,i].argsort()[:2]
    error = calc_error(index[0], result[index[0], i], index[1], result[index[1], i], i)
    print(error)
    err.append(error)
np.cumsum(err)
print('total error : ' + str(np.sum(err)/np.size(err)))