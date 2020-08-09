import matplotlib.pyplot as plt
import pandas as pd

df = pd.read_csv(
    "fritz.txt",
    sep=":",
    index_col=0,
    header=None,
    names=["uptime", "sent", "received", "sent64", "received64"],
)
df.index = pd.to_datetime(df.index, unit="s")

df.plot()
plt.show()
