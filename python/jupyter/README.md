# Jupyter

Tensorflowが利用可能なjupyter環境の起動コマンド dockerを使用
GPUを使用するには--runtime=nvidiaを追加 RADEONはしらない

~~~shell
lab/python/jupyter# docker run -d -v `pwd`/notebooks:/tf -p 8888:8888 --name tensorflow-jupyter --restart=on-failure tensorflow/tensorflow:latest-gpu-jupyter
~~~
