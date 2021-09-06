# ベースイメージ名:タグ名
FROM continuumio/anaconda3:2019.03

# pipをアップグレードし必要なパッケージをインストール
# RUN pip install --upgrade pip && \
#   pip install autopep8 && \
#   pip install Keras && \
#   pip install tensorflow

RUN pip install --upgrade pip
RUN pip install PyGame
RUN pip install PyOpenGL

# コンテナ側のルート直下にworkdir/（任意）という名前の作業ディレクトリを作り移動する
WORKDIR /workdir

# コンテナ側のリッスンポート番号
# 明示しているだけで、なくても動く
EXPOSE 8888

# ENTRYPOINT命令はコンテナ起動時に実行するコマンドを指定（基本docker runの時に上書きしないもの）
# "jupyter-lab" => jupyter-lab立ち上げコマンド
# "--ip=0.0.0.0" => ip制限なし
# "--port=8888" => EXPOSE命令で書いたポート番号と合わせる
# ”--no-browser” => ブラウザを立ち上げない。コンテナ側にはブラウザがないので 。
# "--allow-root" => rootユーザーの許可。セキュリティ的には良くないので、自分で使うときだけ。
# "--NotebookApp.token=''" => トークンなしで起動許可。これもセキュリティ的には良くない。
ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

# CMD命令はコンテナ起動時に実行するコマンドを指定（docker runの時に上書きする可能性のあるもの）
# "--notebook-dir=/workdir" => Jupyter Labのルートとなるディレクトリを指定
CMD ["--notebook-dir=/workdir/contents"]

# RUN conda update -n base -c defaults conda
# RUN conda update jupyterlab
# RUN conda install -c conda-forge nodejs
# # RUN jupyter labextension install @lckr/jupyterlab_variableinspector@3.0.7
# RUN jupyter labextension install @jupyterlab/toc@2.0.0
# RUN jupyter labextension install @jupyterlab/git