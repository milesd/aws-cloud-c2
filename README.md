# Docs
- [Cloud C2 Docs](https://docs.hak5.org/cloud-c2/getting-started/installation-and-setup)
- [Cloud C2 Setup](https://www.youtube.com/watch?v=TIpx_ENurLY)
- [Setting up Cloud C2 as a Service](https://www.youtube.com/watch?v=rgmL75ZBfSI)

# Getting Started
1. Create AWS IAM User w/ necessary permissions and key pair.

2. Create environment variables in GitLab Project > Settings > CI/CD:
    - AWS_REGION
    - AWS_ACCESS_KEY_ID
    - AWS_SECRET_ACCESS_KEY

3. Clone the repository

4. Update hostname parameters in bash script for resource "aws_lightsail_instance"
    - Example: "cc2.kennethcarnes.com"

5. Push to man in GitLab CI/CD

6. Create a A record using your public DNS hosting provider

7. Connect to Cloud C2 via web browser
	- Example: http://cc2.kennethcarnes.com:8080

8. If this the first time you are configuring Cloud C2, you will need to retrieve the setup token.
	- Connect to instance w/ LightSail Connect SSH
	- cd /var/log
	- sudo cat cloud-init-output.log

## Project Status
I hope to add additional features to make the process easier.
- Provide output of setup token with out logging into Lightsail
- Use GoDaddy API to update DNS Record
- SSL
- Potentially an easy way to start/stop the Lightsail instance after it is built




# Notes

```
Usage of ./c2-3.2.0_amd64_linux:
  -certFile string
    	Custom SSL Certificate file (disabled letsencrypt)
  -db string
    	Path to the c2 database (default "c2.db")
  -debug
    	Enable server side debug logs. This will affect performance, only use while actively troubleshooting. Setting this sets -v automatically
  -hostname string
    	 REQUIRED - Hostname of server (ip or DNS name)
  -https
    	Enable https (requires ports 80 and 443)
  -keyFile string
    	Custom SSL Key file (disables letsencrypt)
  -listenip string
    	IP address to listen on (default "0.0.0.0")
  -listenport string
    	Port of the HTTP server (default "8080")
  -recoverAccount string
    	username to recover, specify a new password with -setPass
  -reverseProxy
    	If set, Cloud C2 will work behind a reverse proxy
  -reverseProxyPort string
    	If reverseProxyPort is set, this port will be the internet facing port the Cloud C2 will be available at
  -setEdition string
    	used to update a license key edition from the command line if UI fails
  -setLicenseKey string
    	 used to update a license key from the command line if UI fails
  -setPass string
    	password to set for user specified by name using the -recoverAccount argument
  -sshport string
    	Port of the SSH server (default "2022")
  -v	Set to get timestamped stdout output
```