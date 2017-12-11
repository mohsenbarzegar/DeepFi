# -*- coding: utf-8 -*-
"""
Created on Sat Dec  9 16:05:16 2017

@author: Mohsen.B
"""

from scipy.io import loadmat
import numpy as np
import tensorflow as tf
from sklearn.preprocessing import scale
from keras.models import Sequential
from keras.layers import Dense, Dropout

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
from sklearn.preprocessing import MinMaxScaler
sc = MinMaxScaler(feature_range = (0, 1))
x = np.abs(x)
x = sc.fit_transform(x)

# Creating categorical output
from keras.utils.np_utils import to_categorical
y_cat = to_categorical(y, num_classes=None)
y_cat = y_cat[:, 1:]
# Train and test split
#from sklearn.model_selection import train_test_split
#X_train, X_test, y_train, y_test = train_test_split(
#    x, y_cat, test_size=0.15, random_state=42)

X_train = x[60:, :]
y_train = y_cat[60:, :]
X_test = x[:60, :]
y_test = y_cat[:60, :]

nb_epochs = 200
batch_size = 10
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

def decoder(e, inp):   
    e.add(Dense(17, input_dim=27, activation='tanh', bias=True, name="K3_"))
    e.add(Dense(23, input_dim=17, activation='tanh', bias=True, name="K2_"))
    e.add(Dense(45, activation='tanh', bias=True, name="K1_"))
    e.add(Dense(input_size, activation='tanh', bias=True, name="K0"))
    e.compile(optimizer='adam', loss='mse')
    return e

e = encoder()
inp = e.outputs()
d = decoder(e)
d.fit(X_train, X_train, nb_epoch=nb_epochs, batch_size=batch_size)

def classifier(d):
    num_to_remove = 3
    for i in range(num_to_remove):
        d.pop()
    d.add(Dense(23, input_dim=17, activation='tanh', bias=True))
    d.add(Dense(23, activation='tanh', bias=True))
    d.add(Dense(num_classes, activation='softmax', bias=True))
    d.compile(optimizer='adam', loss='categorical_crossentropy',metrics=['accuracy'])
    return d

c = classifier(d)
c.fit(X_train, y_train, nb_epoch=nb_epochs, batch_size=batch_size)
y_pre = c.predict(X_test)
y_pred = (y_pre > 0.5)

loss, acc = c.evaluate(X_test, y_test)
print(str(loss) + str(acc))

# Making the Confusion Matrix
from sklearn.metrics import accuracy_score
print(accuracy_score(y_test, y_pred))