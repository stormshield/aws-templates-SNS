
# Inter-subnet traffic inspection in AWS VPC using NAT

AWS route tables have a local route for the VPC network at the highest priority and this route can't be overloaded. Thus it is not directly possible to inspect with a SNS EVA the traffic from one subnet to another subnet.

One solution is to use a virtual network addressing to force the inter-subnet traffic to use the default route of the VPC router and be analyzed by the SNS EVA VM. The SNS EVA do the address translation needed to recover the real IP addresses.

The CloudFormation template deploys a web application in the frontend subnet which connects to a database in the backend subnet. The application configuration is edited to use the virtual IP address of the database server.

![aws](img/awsnat.png)

The filtering and nat configuration of the SNS EVA:

![filter](img/filter2.png)
![nat](img/nat2.png)


## Template deployment

- In CloudFormation create a new stack and upload the yaml template (vpc-subnet-filtering-nat.yaml).

- In the Parameters form, choose an existing EC2 key pair and create the stack.

- When the stack is deployed, go to the output tab and get the SNS EVA web-admin url.

![Output](img/output.png)

- Logon using the instance ID as default password and restore the provided backup file (sns-nat.na). 

- The web and database applications will then be deployed on the Ubuntu servers. A few moment later the web app will be available (see the output tab for the url). Hit the web app page a few times.

![web-app](img/app.png)

- In the web-admin, go to the Audit log / Network traffic screen, you should see the mysql connection between the web server and the database server.

![log](img/log2.png)