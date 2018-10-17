Neuroscience using Python
=========================

Some tutorials using Python for neuroscience. They use only NumPy, SciPy and matplotlib and show how to do everything from scratch.
They are in the form of [Jupyter Notebooks](https://jupyter.org).

I have tried to provide clear installation instructions below. 

## 1. Install a python environment

Install the Anaconda python distribution. It comes in two flavors: Anaconda and Miniconda. For the purposes of our exercise, Miniconda distribution will be enough. If you already have a working Anaconda installation, you can use that too.
 
### Linux

1. Download the installer here: https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
1. Open a terminal and run the following command: `bash /path/to/Downloads/Miniconda3-latest-Linux-x86_64.sh` (change the path to point to wherever you saved the installer script.)
1. Follow the installation instructions on the screen.
1. When prompted `Do you wish the installer to prepend the Miniconda3 install location to PATH in your ~/.bash_profile ? [yes|no]` type `yes` (unless you are running a different shell than BASH in which case it's up to you to add Miniconda3 to your `PATH`.)
1. Close the terminal window and open a new one. Try running the `conda` command. If you get a `conda: command not found` error, Miniconda3 is not properly set in your `PATH`. 

### Mac

1. Download the installer here: https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
1. Open `Terminal.app` and run the following command: `bash /path/to/Downloads/Miniconda3-latest-MacOSX-x86_64.sh` (change the path to point to wherever you saved the installer script.)
1. Follow the installation instructions on the screen.
1. When prompted `Do you wish the installer to prepend the Miniconda3 install location to PATH in your /Users/<username>/.bash_profile ? [yes|no]` choose yes (unless you are running a different shell than BASH in which case it's up to you to add Miniconda3 to your `PATH`.)
1. Close the terminal window and open a new one. Try running the `conda` command. If you get a `conda: command not found` error, Miniconda3 is not properly set in your `PATH`. 

### Windows

1. Download the installer here: https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86_64.exe
1. Run it and follow the instructions on the screen.
1. The "Anaconda Prompt" application should now be available on your Start menu. Open it.
1. Try running the `conda` command in the terminal window that you just opened.


## 2. Use Anaconda to install the required Python packages

1. Open a terminal for running anaconda. On Linux and OSX, just open a regular terminal window. On windows, you can use the "Anaconda Prompt" entry in your Start menu. 
1. Run `conda install numpy scipy matplotlib jupyter`
1. Watch the installation process scroll by.
1. Run `python -c "import numpy, scipy, matplotlib"` to see if the installation was succesfull. The command should not give you any errors and finish silently.


## 3. Launch the Jupyter Notebook environment

1. Download the tutorial notebooks in this repository
1. In your Miniconda3 terminal, change your working directory to the path you've saved the `.ipynb` files to (the command to do this is `cd`).
1. In the directory where the notebook files live, run the following command: `jupyter notebook`. This should open up a browser window showing the contents of your current working directory. It will also write the URL to the terminal so you can point your browser to it manually if need be.
1. In the browser, click on one of the notebook files to open it.
