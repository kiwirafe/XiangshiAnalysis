import plotly.graph_objects as go
import numpy as np
import itertools


f = open("result/Long Text Original.txt", "r").readlines()
df = []
for x in f:
    st = x.split(" ")
    df.append(st[-1][:-1])

numx = np.arange(1, 40)
numy = np.array(df)

fig = go.Figure()
fig.add_trace(go.Scatter(x=numx, y=numy,
                    mode='lines+markers',
                    name='lines+markers'))

fig.show()
