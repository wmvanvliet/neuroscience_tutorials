FROM jupyter/minimal-notebook:703d8b2dcb88

MAINTAINER Marijn van Vliet <w.m.vanvliet@gmail.com>

# Install core debian packages
USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
    && apt-get install -yq --no-install-recommends \
    openssh-client \
    vim \ 
    curl \
    gcc \
    && apt-get clean

# Xvfb
RUN apt-get install -yq --no-install-recommends \
    xvfb \
    x11-utils \
    libx11-dev \
    qt5-default \
    && apt-get clean

ENV DISPLAY=:99

# Switch to notebook user
USER $NB_UID

# Upgrade the package managers
# RUN pip install --upgrade pip
# RUN npm i npm@latest -g

# Install Python packages
RUN pip install vtk && \
    pip install numpy && \
    pip install scipy && \
    pip install pandas && \
    pip install pyqt5 && \
    pip install xvfbwrapper && \
    pip install mayavi && \
    pip install ipywidgets && \
    pip install ipyevents && \
    pip install pillow && \
    pip install scikit-learn && \
    pip install nibabel && \
    pip install pysurfer && \
    pip install mne && \
    pip install https://github.com/aaltoimaginglanguage/conpy/archive/master.zip && \
    pip install https://github.com/wmvanvliet/posthoc/archive/master.zip

# Install Jupyter notebook extensions
RUN pip install RISE && \
    jupyter nbextension install rise --py --sys-prefix && \
    jupyter nbextension enable rise --py --sys-prefix && \
    jupyter nbextension install mayavi --py --sys-prefix && \
    jupyter nbextension enable mayavi --py --sys-prefix && \
    npm cache clean --force

# Clone the repository. First fetch the hash of the latest commit, which will
# invalidate docker's cache when new things are pushed to the repository. See:
# https://stackoverflow.com/questions/36996046
ADD https://api.github.com/repos/wmvanvliet/neuroscience_tutorials/git/refs/heads/master version.json
RUN git init . && \
    git remote add origin https://github.com/wmvanvliet/neuroscience_tutorials.git && \
    git pull origin master

# Download the datasets
RUN wget "https://github.com/wmvanvliet/neuroscience_tutorials/releases/download/2/mne-intro-data.zip" -O mne-intro-data.zip
RUN unzip mne-intro-data.zip -d mne-intro/
RUN rm mne-intro-data.zip

RUN wget "https://github.com/wmvanvliet/neuroscience_tutorials/releases/download/2/eeg-bci-data.zip" -O eeg-bci-data.zip
RUN unzip eeg-bci-data.zip -d eeg-bci/
RUN rm eeg-bci-data.zip

RUN wget "https://github.com/wmvanvliet/neuroscience_tutorials/releases/download/2/conpy-intro-data.zip" -O conpy-intro-data.zip
RUN unzip conpy-intro-data.zip -d conpy-intro/
RUN rm conpy-intro-data.zip

RUN wget "https://github.com/wmvanvliet/neuroscience_tutorials/releases/download/2/eeg-erp-data.zip" -O eeg-erp-data.zip
RUN unzip eeg-erp-data.zip -d eeg-erp/
RUN rm eeg-erp-data.zip

# Configure the MNE raw browser window to use the full width of the notebook
RUN ipython -c "import mne; mne.set_config('MNE_BROWSE_RAW_SIZE', '9.8, 7')"

# Add an x-server to the entrypoint. This is needed by Mayavi
ENTRYPOINT ["tini", "-g", "--", "xvfb-run"] 
