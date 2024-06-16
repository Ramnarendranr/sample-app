# Project Setup Documentation

## Table of Contents

```
Introduction
Prerequisites
Setting Up EC2 Instances
Configuring Jenkins Server
Configuring SonarQube Server
Next Steps
Introduction
```

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
