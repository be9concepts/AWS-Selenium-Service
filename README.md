# AWS-Selenium-Service
Selenium Service for use with AWS EC2, Amazon Alexa &amp; IFTTT MakerWebhooks

 | - Run Selenium Tests in the Cloud with Amazon Alexa
 | - Select from a directory of multiple test

## Installation

Dillinger uses a number of open source projects to work properly:

* [Selenium]('') - HTML enhanced for web apps!
* [Python2.7]('')
* [xvfb]()
* [X Server Core]() & [Required Fonts]()
* [Chrome and Chromedriver]()
* [FireFox]()

Begin by installing the required packages

```
sudo apt-get update
sudo apt-get -y install xvfb
sudo apt-get -y install xserver-xorg-core
sudo apt-get -y install xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" << /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get -y install google-chrome-stable
wget http://chromedriver.googlecode.com/files/chromedriver_linux64_23.0.1240.0.zip 
sudo apt-get -y install unzip
unzip chromedriver_linux64_23.0.1240.0.zip
sudo cp chromedriver /usr/local/bin
```

## Startup

Start the required services (see below for startup on server launch)

```sh
Xvfb :99 -screen 0 1024x768x24 -ac 2<&1 </dev/null &
export DISPLAY=:99
```
| Running Selenium Server On Start-Up
Now that we have a working instance of Selenium Server, we would ideally like to automate running Selenium Server to avoid having to log into every machine and manually start it. Fortunately, Linux makes the task of automating scripts at start-up easy. We can add our commands required to start xvfb and Selenium Server to /etc/rc.local

1. Open /etc/rc.local for editing using nano (or your favourite editor):
	```
    sudo nano /etc/rc/local
    ```
2. Enter the following lines before the last exit 0 line. Note: last two lines need to be entered as a single line.
    ```
    # Start Required Server and Virtual Display
    Xvfb :99 -screen 0 1024x768x24 -ac 2<&1 </dev/null &
    export DISPLAY=:99
    # Start Selenium Service
    sudo bash /home/ubuntu/Selenium-IFTTT/ifttt-watcher.sh
    ```
    
3. Press Ctrl+X to exit nano and Y when prompted to save changes.
4. Restart the server
    ```
    sudo shutdown –r now
    ```
    Now every time the AWS EC2 Instance is lanched the service will start automatically 

## Usage

### Installing Tests

1. Export tests from Selenium IDE as Python WebDriver
2. [Connect to the AWS EC2 Instance]('https://forums.aws.amazon.com/thread.jspa?messageID=741338')
3. Upload exported tests to *~/Selenium-IFTTT/tests*
4. `~ File names should contain only lowercase characters!`


### Using IFTTT's Maker WebHooks
This service relies on a web server to hold the `state` and `command`
The script expects a response from the server as: `state`*.*`command`

1. Make note of the file name for the test you would like to trigger
2. Navigate to [IFTTT's MakerWebhooks]('https://ifttt.com/maker_webhooks')
3. Create a [New Applet]('https://ifttt.com/create')
4. For **THIS** use whatever you would like to trigger the test.
5. For **THAT** select WebHooks
6. Use your servers url+**/update.php?state=true&command=`yourcommandname`**
7. 
### Todos

 - Host web server with Amazon

