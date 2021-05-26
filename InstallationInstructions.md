
---
Installation Instructions
---

## Installing Python Using Anaconda

[Python][python] is great for general-purpose programming and is a popular language
for scientific computing as well. Installing all of the packages required for this
lessons individually can be a bit difficult, however, so we recommend the all-in-one
installer [Anaconda][anaconda].

Regardless of how you choose to install it, please make sure you install Python
version 3.x (e.g., Python 3.6 version). 

### Windows - [Video tutorial][video-windows]

1. Open [anaconda.com/download][anaconda-dl]
   with your web browser.

2. Download the Python 3 installer for Windows.

3. Double-click the executable and install Python 3 using _MOST_ of the
   default settings. The only exception is to check the
   **Make Anaconda the default Python** option.

### macOS - [Video tutorial][video-mac]

1. Open [anaconda.com/download][anaconda-dl]
   with your web browser.

2. Download the Python 3 installer for macOS.

3. Install Python 3 using all of the defaults for installation.

### Linux

Note that the following installation steps require you to work from the shell.
If you run into any difficulties, please request help before the workshop begins.

1.  Open [anaconda.com/download][anaconda-dl] with your web browser.

2.  Download the Python 3 installer for Linux.

3.  Install Python 3 using all of the defaults for installation.

    a.  Open a terminal window.

    b.  Navigate to the folder where you downloaded the installer

    c.  Type

    ~~~
    $ bash Anaconda3-
    ~~~
    {: .bash}

    and press tab.  The name of the file you just downloaded should appear.

    d.  Press enter.

    e.  Follow the text-only prompts.  When the license agreement appears (a colon
        will be present at the bottom of the screen) hold the down arrow until the
        bottom of the text. Type `yes` and press enter to approve the license. Press
        enter again to approve the default location for the files. Type `yes` and
        press enter to prepend Anaconda to your `PATH` (this makes the Anaconda
        distribution the default Python).

### Starting Python

We will teach Python using [Jupiter Notebook][jupyter]. If you installed Python using Anaconda, **Jupyter Notebook** should already be on your system. If
you did not use Anaconda, use the Python package manager pip
(see the [Jupyter website][jupyter-install] for details.)

To start Jupyter Notebook Open the Anaconda Navigator and Launch Jupyter Notebook

[anaconda]: https://www.anaconda.com/distribution
[anaconda-dl]: https://www.anaconda.com/download/
[python]: https://python.org
[jupyter]: https://jupyter.org/index.html
[jupyter-install]: https://jupyter.org/install.html
[video-mac]: https://www.youtube.com/watch?v=TcSAln46u9U
[video-windows]: https://www.youtube.com/watch?v=xxQ0mzZ8UvA


## Install R and RStudio

R and RStudio are two separate pieces of software: 

* **R** is a programming language that is especially powerful for data 
  exploration, visualization, and statistical analysis
* **RStudio** is an integrated development environment (IDE) that makes using 
  R easier. In this course we use RStudio to interact with R. 
  
If you don't already have R and RStudio installed, follow the instructions for 
your operating system below. You have to install R before you install RStudio. 

### Windows

* Download R from the 
  [CRAN website](https://cran.r-project.org/bin/windows/base/release.htm).
* Run the `.exe` file that was just downloaded
* Go to the [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download)
* Under *Installers* select **RStudio x.yy.zzz - Windows
  Vista/7/8/10** (where x, y, and z represent version numbers)
* Double click the file to install it
* Once it's installed, open RStudio to make sure it works and you don't get any
  error messages.

##### MacOS

* Download R from
  the [CRAN website](https://cran.r-project.org/bin/macosx/).
* Select the `.pkg` file for the latest R version
* Double click on the downloaded file to install R
* It is also a good idea to install [XQuartz](https://www.xquartz.org/) (needed
  by some packages)
* Go to the [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download)
* Under *Installers* select **RStudio x.yy.zzz - Mac OS X 10.6+ (64-bit)**
  (where x, y, and z represent version numbers)
* Double click the file to install RStudio
* Once it's installed, open RStudio to make sure it works and you don't get any
  error messages.

#### Linux

* Follow the instructions for your distribution
  from [CRAN](https://cloud.r-project.org/bin/linux), they provide information
  to get the most recent version of R for common distributions. For most
  distributions, you could use your package manager (e.g., for Debian/Ubuntu run
  `sudo apt-get install r-base`, and for Fedora `sudo yum install R`), but we
  don't recommend this approach as the versions provided by this are
  usually out of date. In any case, make sure you have at least R 3.3.1.
* Go to the
  [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download)
* Under *Installers* select the version that matches your distribution, and
  install it with your preferred method (e.g., with Debian/Ubuntu `sudo dpkg -i
  rstudio-x.yy.zzz-amd64.deb` at the terminal).
* Once it's installed, open RStudio to make sure it works and you don't get any
  error messages.

### Update R and RStudio

If you already have R and RStudio installed, check if your R and RStudio are 
up to date:

* When you open RStudio your R version will be printed in the console on 
  the bottom left. Alternatively, you can type `sessionInfo()` into the console.
  If your R version is 4.0.0 or later, you don't need to update R for this 
  lesson. If your version of R is older than that, download and install the 
  latest version of R from the R project website
  [for Windows](https://cran.r-project.org/bin/windows/base/), 
  [for MacOS](https://cran.r-project.org/bin/macosx/),
  or [for Linux](https://cran.r-project.org/bin/linux/)
* To update RStudio to the latest version, open RStudio and click on 
  `Help > Check for updates`. If a new version is available, quit RStudio, 
  follow the instruction on screen.
  
Note: It is not necessary to remove old versions of R from your system, 
but if you wish to do so you can 
[check here.](https://cran.r-project.org/bin/windows/base/rw-FAQ.html#How-do-I-UNinstall-R_003f) 
  
[Credits](https://datacarpentry.org/R-ecology-lesson/#Install_R_and_RStudio)

