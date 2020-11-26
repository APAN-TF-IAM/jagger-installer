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
 
If the script completes without error the following will have been installed and configured.

   | Software | Description |
   |----------|-------------|
   | Apache   | Web server | 
   | MariaDB | Database engine that holds the federation data |
   | memcached | Caching server used by the Registry software |
   | php | Version 7.4 of PHP with a modified /etc/php.ini |
   | rr3 | The Jagger Resource Registry software from HEAnet |

The Resource Registry should now be ready for setup and final configuration.

## Setup

Setup will create the first admin account needed to login to the registry. Navigate to the setup page on your registry.

   ```
   https://[FQDN-of-your-server]/rr3/setup
   ```

You will see a Certificate error as the default Apache certificate is in use. Before releasing your Jagger you need
to add a signed certificate to your Apache server. This is left for you to action.

A form should appear asking for user details. Complete the form and submit. The following message should appear
below the submit button.

   ```
   Done! Don't forget to disable "setup allowed" in config file 
   ```

## Disable Setup

Next we must disable the Setup option. Edit the file /opt/rr3/application/config/config_rr.php and
set 'rr_setup_allowed' to FALSE.

   ```
   $config['rr_setup_allowed'] = FALSE;
   ```

## First Login

You are now ready to login to the Jagger Resource Registry for the first time. Navigate to the following address
and use the username / password you entered in the setup screen;

   ```
   https://[FQDN-of-your-server]/rr3
   ```

### Configuration tasks

To complete the setup of your Jagger there are a number of tasks that need to be completed from the Web user interface.

1. Check and verify the system setup. Navigate to the Administration tab and select the System option. There will be four processes, run each in turn.

    * Validate ORM version, PHP version
    * Validate database schema files
    * Validate if database schema files are in sync with database
    * Check and run data upgrade/migration if needed

    All should respond with 1 or more green bars indicating all is good.

2. Web configuration settings. Navigate to the Administration tab and select the Configuration option. A list of options will appear. Review each, enable or diable which options that are appropriate for your setup.

3. Add an artical for display on the home page of your Jagger. Navigate to the Administration tab and select the Manage Articles option.

    The default home page article MUST have an Article ID equal to "front_page", it should be Visible for ananymous and Enabled. It will then diplay for everyone, logged in or not.




