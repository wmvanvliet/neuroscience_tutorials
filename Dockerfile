FROM quay.io/jupyter/datascience-notebook:notebook-7.1.3

LABEL org.opencontainers.image.authors="Marijn van Vliet <w.m.vanvliet@gmail.com>"

# Install git
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -yq dist-upgrade \
    && apt-get install -yq --no-install-recommends \
    git \
	wget \
	unzip \
    && apt-get clean

# Switch to notebook user
USER $NB_UID

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

RUN wget "https://github.com/wmvanvliet/neuroscience_tutorials/releases/download/2/rsa-data.zip" -O rsa-data.zip
RUN unzip rsa-data.zip -d rsa/
RUN rm rsa-data.zip

# Install Python packages
RUN pip install \
	imageio \
	imageio-ffmpeg \
    pyvista \
	ipympl \
    ipywidgets \
    ipyevents \
	jupyter-server-proxy \
	jupyterlab \
	meshio \
	pandas \
    pillow \
	RISE \
    scikit-learn \
    nibabel \
    mne \
    mne-rsa \
    trame \
	trame-vuetify \
	trame-vtk \
    pyside6 \
    pyvistaqt \
	trimesh \
    https://github.com/aaltoimaginglanguage/conpy/archive/master.zip \
    https://github.com/wmvanvliet/posthoc/archive/master.zip

# Install vtk-osmesa wheel
RUN pip uninstall vtk -y
RUN pip install --no-cache-dir --extra-index-url https://wheels.vtk.org vtk-osmesa

# allow jupyterlab for ipyvtk
ENV JUPYTER_ENABLE_LAB=yes
ENV PYVISTA_TRAME_SERVER_PROXY_PREFIX='/proxy/'

# Configure the MNE raw browser window to use the full width of the notebook
RUN ipython -c "import mne; mne.set_config('MNE_BROWSE_RAW_SIZE', '9.8, 7')"

# Clone the repository. First fetch the hash of the latest commit, which will
# invalidate docker's cache when new things are pushed to the repository. See:
# https://stackoverflow.com/questions/36996046
ADD https://api.github.com/repos/wmvanvliet/neuroscience_tutorials/git/refs/heads/master version.json
RUN git init . && \
    git remote add origin https://github.com/wmvanvliet/neuroscience_tutorials.git && \
    git pull origin master
