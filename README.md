# JAGGER - Automated installation

This tool provides an automated installation of the [HEAnet Jagger (ResourceRegistry3)](https://jagger.heanet.ie/).
The installation is based on the [JAGGER - Admin Guide Draft 1.0 documentation](https://jagger.heanet.ie/jaggerdocadmin/). It will install and configure all of supporting software (Apache, PHP, MariaDB, etc) and JAGGER itself ready for use by your federation or orgranisation.

## System Requirements

1. A dedicated CentOS 7 or 8 server (virtual or physical), with the following minimum specifications:

    * 2 CPUS
    * 4 GB RAM
    * 10GB+ partition for OS

2. You MUST have SSH access to the server
3. You MUST be able to execute commands as *root* on the system without limitation
4. The server MUST be routable from the public internet with a static IP. Often this means configuring the IP on a local network interface directly but advanced environments may handle this differently.
5. The static IP MUST have a publicly resolvable DNS entry. Typically of the form *rr.example.org*
6. The server MUST be able to communicate with the wider internet without blockage due to firewall rules. All publicly routable servers MUST be accessible for:

    | Port | Purpose |
    |------|---------|
    | 80   | Outbound HTTP connections |
    | 443  | outbound HTTPS connections |

    Each of the following commands MUST succeed when run *on your server*:

      1. `curl http://example.edu`
      2. `curl https://example.edu`

7. The server MUST be accessible from the wider internet without blockage due to firewall rules for:

    | Port | Purpose |
    |------|---------|
    | 80   | Inbound HTTP connections used within SAML flows  |
    | 443  | Inbound HTTPS connections used within SAML flows  |

## Getting Started

To begin you MUST clone the Jagger installer repository to your server. Install git on your server i
using the following command;

    ```
    yum -y install git
    ```
 
Then clone the Jagger installer repostory;

   ```
   git clone https://github.com/APAN-TF-IAM/jagger-installer.git
   ```

The directory jagger-installer will be created as a result of the clone. Change to this directory;

   ```
   cd jagger-installer
   ```
There are several file to edit that are specific to your environment.

    | File name | Line to edit | Value |
    |-----------|--------------|-------|
    | ansible_hosts | Line #2 | Replace the host name with the fully qualified domain name (FQDN) of your server |
    | site.yml | vars.config.support_mailto | Replace with appropriate email address | 
    |          | vars.config.registrationAutority | Replace with appropriate URL |

## Deploy

Run the deploy script. This script MUST by run as root.

   ```
   ./deploy
   ```
 

