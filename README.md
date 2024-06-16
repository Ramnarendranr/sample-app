# Jenkins CI-CD Project Setup Documentation

## Table of Contents

```
Introduction
Prerequisites
Setting Up EC2 Instances
Configuring Jenkins Server
Configuring SonarQube Server
Installing Nexus on Nexus Server
Install Tomcat on Tomcat Server
Add Jenkinsfile (Pipeline Script)
Build and test
```

### Introduction


This document provides a step-by-step guide for setting up a CI/CD pipeline using Jenkins, Nexus, Tomcat, and SonarQube. It includes creating EC2 instances, installing necessary software, and configuring the environment to build and deploy a Java web application from a Git repository.

### Prerequisites

* AWS account with permissions to create EC2 instances and security groups.
* Basic knowledge of Linux commands and SSH.
* Setting Up EC2 Instances

**Step 1: Create EC2 Instances**

Create four EC2 instances with the following configurations:
```
Jenkins Server: Open port 8080
Tomcat Server: Open port 8080
Nexus Server: Open port 8081
SonarQube Server: Open port 9000
```
Ensure each instance has a security group that allows inbound traffic on the specified ports.

**Step 2: SSH into Each Instance**
Use the following command to SSH into each instance:

```
ssh -i /path/to/your-key.pem ec2-user@your-instance-public-ip
```

## Configuring Jenkins Server

### Step 3: Install Jenkins and Maven on Jenkins Instance**

**SSH into the Jenkins instance and switch to the root user:**

```sudo su```

**Update the package lists:**

```sudo apt update -y```

**Add the Jenkins repository and import the GPG key:**

```echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null```

**Install Java:**

```sudo apt install openjdk-11-jre-headless -y```

**Install Jenkins:**

```sudo apt-get update```
```sudo apt-get install jenkins -y```

**Start and enable Jenkins service:**

```
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
```

**Retrieve the Jenkins initial admin password:**

```sudo cat /var/lib/jenkins/secrets/initialAdminPassword```

**Install Maven:**

```
cd /opt/
wget https://dlcdn.apache.org/maven/maven-3/3.9.7/binaries/apache-maven-3.9.7-bin.tar.gz
tar -xvzf apache-maven-3.9.7-bin.tar.gz
mv apache-maven-3.9.7/ maven-3.9
export PATH=$PATH:/opt/maven-3.9/bin
mvn -version
vi ~/.bashrc
```

**Add the following line at the end of the ~/.bashrc file to make the Maven path permanent:**

```export PATH=$PATH:/opt/maven-3.9/bin```

**Source the .bashrc file and verify Maven installation:**

```
source ~/.bashrc
mvn --version
```

## Configuring SonarQube Server

### Step 4: Install SonarQube
**SSH into the SonarQube instance and switch to the root user:**

```sudo su```

**Update the package lists and install Java:**

```
sudo apt update
sudo apt install openjdk-11-jre-headless -y
```

**Install SonarQube:**

```
cd /opt/
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.10.61524.zip
sudo apt install unzip
unzip sonarqube-8.9.10.61524.zip
mv sonarqube-8.9.10.61524/ sonarqube-8
rm -rf sonarqube-8.9.10.61524.zip
```

**Create a SonarQube user and set permissions:**

```
useradd sonar
passwd sonar
chown -R sonar:sonar sonarqube-8/
```

**Start SonarQube:**

```
cd sonarqube-8/bin/linux-x86-64/
vim sonar.sh
```

In the sonar.sh file, add **run as user 'sonar'**

```
./sonar.sh start
./sonar.sh status
```


## Installing Nexus on Nexus Server

### Step 5: Install Nexus on Nexus Server

**SSH into the Nexus instance and switch to the root user:**

```
sudo su
```

**Verify the Java installation:**

```
java -version
```

**Update the package lists:**

```
sudo apt update -y
```

**Install OpenJDK 8:**

```
sudo apt install openjdk-8-jre-headless -y
```

**Verify the Java installation again:**

```
java -version
```

**Navigate to the /opt/ directory and Download and extract the Nexus tarball:**

```
cd /opt/
wget https://download.sonatype.com/nexus/3/nexus-3.69.0-02-java8-unix.tar.gz
tar -xvzf nexus-3.69.0-02-java8-unix.tar.gz
rm -rf nexus-3.69.0-02-java8-unix.tar.gz
```

**Create a Nexus user:**
```
useradd nexus
```

**Set a password for the Nexus user:**

```
passwd nexus
```

**Change the ownership of the Nexus and Sonatype work directories:**

```
chown -R nexus:nexus nexus-3.69.0-02/
chown -R nexus:nexus sonatype-work/
```

**Edit the nexus.rc file to set the Nexus user:**
```
cd nexus-3.69.0-02/bin/
vim nexus.rc
```

**In the nexus.rc file, add the following line:**

```
run_as_user="nexus"
```

**Start the Nexus service:**
```
./nexus start
./nexus status
```

Now access it through <public-ip-of-nexus-instance>:8081



## Step 6: Install Tomcat on Tomcat Server

**Download apache Tomcat:**
```
sudo su
sudo apt update -y
cd /opt/
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.tar.gz
tar -xvzf apache-tomcat-9.0.89.tar.gz
rm -rf apache-tomcat-9.0.89.tar.gz
mv apache-tomcat-9.0.89/ tomcat-9
```

**Change ownership of the Tomcat directory to the ubuntu user (assuming ubuntu is the user):**
```
sudo chown -R ubuntu:ubuntu tomcat-9/
```

**Start Tomcat:**
```
cd tomcat-9/bin/
./startup.sh
```

**Verify Java installation, Install OpenJDK 11 (if not already installed)::**
```
java -version
sudo apt install openjdk-11-jre-headless -y
```

**Restart Tomcat to ensure changes take effect:**
```
./shutdown.sh
./startup.sh
```

**Navigate to the Tomcat manager application configuration directory, Edit the context.xml file to configure remote access (comment out Valve configuration)::**
```
cd /opt/tomcat-9/webapps/manager/META-INF/
vim context.xml
```

Comment out the following line:
```
<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
          allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
```

**Create symbolic links for starting and stopping Tomcat from anywhere:**
```
ln -s /opt/tomcat-9/bin/startup.sh /usr/bin/startTomcat
ln -s /opt/tomcat-9/bin/shutdown.sh /usr/bin/stopTomcat
ls -lrt /usr/bin/
```

**Navigate to the Tomcat configuration directory, Edit the tomcat-users.xml file to configure manager roles and users::**
```
cd ../conf/
vim tomcat-users.xml
```

**Add the following lines (typically near the end of the file):**

```
<role rolename="manager-gui"/>
<role rolename="admin-gui"/>
<user username="tomcat" password="tomcat" roles="manager-gui,admin-gui"/>
```

**Restart Tomcat to apply the user and role configurations:**

```
stopTomcat
startTomcat
```

### Access Tomcat Manager
Now, access the Tomcat Manager application through the public IP address of your Tomcat instance using port 8080 (e.g., http://<public_ip_of_tomcat>:8080/manager). 
**Log in with the username tomcat and password tomcat configured earlier.**


## Step 7: Configure Jenkins Credentials

**Access Jenkins Dashboard:**

Open your web browser and go to Jenkins using the public IP address of your Jenkins EC2 instance on port 8080 (e.g., http://<public_ip_of_jenkins>:8080).

**Log in to Jenkins:**

Use the initial admin password obtained during Jenkins setup to log in.

**Navigate to Credentials:**

* Click on Manage Jenkins on the Jenkins homepage.
* Click on Manage Credentials from the options.

**Add SonarQube Token:**
```
Click on Global credentials (unrestricted) or a specific domain based on your setup.
Click on Add Credentials.
Choose Secret text as the kind of credential.
Enter the SonarQube token in the Secret field.
Optionally, provide an ID and description.
Click OK to save the credential.
```

**Add Tomcat Credentials:**
```
Click on Add Credentials again.
Choose Secret text as the kind of credential.
Enter the Tomcat username and password in the respective fields.
Optionally, provide an ID and description.
Click OK to save the credential.
```

**Add Nexus Credentials:**
```
Click on Add Credentials again.
Choose Username with password as the kind of credential.
Enter the Nexus username and password.
Optionally, provide an ID and description.
Click OK to save the credential.
```

**Verify Credentials:**
```
Ensure all credentials are correctly saved and visible in the Jenkins credentials store.
```

## Step 8: Add Jenkinsfile (Pipeline Script)

Create a Jenkinsfile:

In your project repository (where your Maven project is located), create a file named Jenkinsfile.
This file will define the Jenkins pipeline stages and steps for building, testing, and deploying your application.

You can write the groovy syntax directly in jenkins or write a separate jenkinsfile store it in github and use the path of the jenkinsfile in jenkins.

Now build the project and check for any vulnerabilities in sonarqube.
If build is success, you'll be able to see the repo.
Also, the deployment should be sccessful, the server should be working fine
