import plotly.graph_objects as go
import numpy as np
import itertools

results = []
results.append(open("result/Long Text Original.txt", "r").readlines())
results.append(open("result/Long Text Random 700 (One Over Tenth).txt", "r").readlines())
results.append(open("result/Long Text Top 700 (One Over Tenth).txt", "r").readlines())
results.append(open("result/Short Text Original.txt", "r"))

numx = np.arange(1, 40)

numys = []

for item in results:
    df = []
    for x in item:
        st = x.split(" ")
        num = st[-1][:-1]
        df.append(num)
    numys.append(np.array(df))

fig = go.Figure()
fig.add_trace(go.Scatter(x=numx, y=numys[0],
                    mode='lines+markers',
                    name='Long Text Original'))
fig.add_trace(go.Scatter(x=numx, y=numys[1],
                    mode='lines+markers',
                    name='Long Text Random 700 (One Over Tenth)'))
fig.add_trace(go.Scatter(x=numx, y=numys[2],
                    mode='lines+markers',
                    name='Long Text Top 700 (One Over Tenth)'))
fig.add_trace(go.Scatter(x=numx, y=numys[3],
                    mode='lines+markers',
                    name='Short Text Original'))

fig.show()
