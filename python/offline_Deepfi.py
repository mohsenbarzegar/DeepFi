# -*- coding: utf-8 -*-
"""
Created on Mon Dec 11 12:13:30 2017

@author: Mohsen.B
"""

from scipy.io import loadmat
import numpy as np
import tensorflow as tf
from sklearn.preprocessing import scale
from keras.models import Sequential
from keras.layers import Dense, Dropout

# data loading
for n in range(17):
    for i in range(17):
        if i != n :
            continue
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
                    
    # Feature Scaling
    from sklearn.preprocessing import MinMaxScaler
    sc = MinMaxScaler(feature_range = (0, 1))
    x = np.abs(x)
    x = sc.fit_transform(x)
    
    # Creating categorical output
    from keras.utils.np_utils import to_categorical
    y_cat = to_categorical(y, num_classes=None)
    y_cat = y_cat[:, 1:]
    
    X_train = x
    y_train = y_cat
    
    nb_epochs = 500
    batch_size = 5
    input_size = 90
    num_classes = 17
    
    def encoder():
        model = Sequential()
        model.add(Dense(45, input_dim=input_size, activation='tanh', bias=True, name="K1"))
        model.add(Dense(23, activation='tanh', bias=True, name="K2"))
        model.add(Dense(17, activation='tanh', bias=True, name="K3"))
        model.add(Dense(10, activation='tanh', bias=True, name="K4"))
        model.compile(optimizer='adam', loss='mse')
        return model
    
    def decoder(e):   
        e.add(Dense(17, input_dim=27, activation='tanh', bias=True, name="K3_"))
        e.add(Dense(23, input_dim=17, activation='tanh', bias=True, name="K2_"))
        e.add(Dense(45, activation='tanh', bias=True, name="K1_"))
        e.add(Dense(input_size, activation='tanh', bias=True, name="K0"))
        e.compile(optimizer='adam', loss='mse')
        return e
    
    e = encoder()
    d = decoder(e)
    d.fit(X_train, X_train, nb_epoch=nb_epochs, batch_size=batch_size)
    d.save('model\model_'+str(n+1)+'.h5', overwrite=True, include_optimizer=True)

