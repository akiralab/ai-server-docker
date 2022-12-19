# どのイメージを基にするか
FROM nvcr.io/nvidia/pytorch:21.11-py3

# apt-getの更新
RUN apt-get update -y
RUN apt-get upgrade -y

# 関連ライブラリをインストール
RUN apt install -y libsm6 libxext6
RUN apt install -y libxrender-dev

# JupyterLab関連のパッケージ（いくつかの拡張機能を含む）
# 必要に応じて、JupyterLabの拡張機能などを追加してください
RUN python3 -m pip install --upgrade pip \
&&  pip install --no-cache-dir \
    black \
    jupyterlab \
    jupyterlab_code_formatter \
    jupyterlab-git \
    lckr-jupyterlab-variableinspector \
    jupyterlab_widgets \
    ipywidgets \
    import-ipynb
    ipywidgets \
    h5py \
    tqdm \
    ipynb-py-convert \
    neptune-client \
    pillow \

# 基本パッケージ
# Pythonでよく利用する基本的なパッケージです
# JupyterLabの動作には影響しないので、必要に応じてカスタマイズしてください
RUN pip install --no-cache-dir \
    numpy \
    pandas \
    scipy \
    scikit-learn \
    pycaret \
    matplotlib \
    japanize_matplotlib \
    mlxtend \
    seaborn \
    plotly \
    requests \
    beautifulsoup4 \
    Pillow \
    opencv-python

# 追加パッケージ（必要に応じて）
# 各環境に特化したパッケージがある場合、この部分に追加します
RUN pip install --no-cache-dir \
    pydeps \
    graphviz \
    pandas_profiling \
    shap \
    umap \
    xgboost \
    lightgbm

jupyter開始用ファイルのコピー
COPY ./config_files/start.sh /mnt/m2/ex1/

# # ビルド時にsshd_configを修正
# RUN sed -i 's/#PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# RUN sed -i 's/#Port 22/Port 20022/' /etc/ssh/sshd_config

# # conda 設定
# RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && echo "conda activate base" >> ~/.bashrc

# # ビルド時に公開鍵を登録
# COPY ./config_files/ssh_lm1.pub /root/.ssh/authorized_keys

# # コンテナの起動時にsshdを再起動するようにする
# COPY ./config_files/setup.sh /root/
# RUN  chmod a+x /root/setup.sh
# RUN  echo "/root/setup.sh" >> /root/.bashrc
