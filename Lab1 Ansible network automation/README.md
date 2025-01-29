This code corresponds to "Lab 1 Ansible network automation" on Greenboard

Follow the [tutorial](https://drive.google.com/file/d/1ql1Q_V2kghqbTM1m8qTLfITbBaD8xJEb/view?usp=drivesdk) and upload here an screenshot of the changes made to the cisco router.

You need to look for a public IOS router at the Cisco DevNet platform, look for one of the "AlwaysOn" options and get their credentials.
https://devnetsandbox.cisco.com/DevNet 
![DevNet](https://github.com/user-attachments/assets/6df7056a-e767-4907-b9fa-ca3ef97bdc47)

After setting up your ansible installation you should be able to ping the IOS routers.
<img src="https://github.com/user-attachments/assets/7229ffdb-b561-4630-a44e-afd952edd50d" alt="ping" width="600"/>

Use the provided [devnet.yml](/Lab1%20Ansible%20network%20automation/devnet.yml) file to change the chage the login banner of the IOS routers, you should get a response similar to the following. Note, you may need to update the ios_banner module to use the [latest version](https://docs.ansible.com/ansible/latest/collections/cisco/ios/ios_banner_module.html):
![playbook execution](https://github.com/user-attachments/assets/36e04fa0-7915-4047-b75e-f7468e2d6bcd)

Verify your changes by trying to log in via SSH to the routers.
<img src="https://github.com/user-attachments/assets/71558288-9a4c-4afe-866f-fc039cec6944" alt="Login banner" width="600"/>
