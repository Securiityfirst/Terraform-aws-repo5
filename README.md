
# Terraform-aws-repo5


AWS Infrastructure Build Cloud Security Vulnerability Test Case- README


Overview


This repository provides the necessary configurations and scripts to set up an AWS infrastructure, including network interfaces and EC2 instances. The infrastructure is designed to provide a basic and scalable environment for hosting applications. It includes:

    •    VPC (Virtual Private Cloud)

    •    Subnets

    •    Security Groups

    •    EC2 Instances

    •    Network Interfaces (ENI)

    •    Route Tables


The infrastructure is automated through AWS CloudFormation or Terraform scripts, allowing you to deploy and manage your AWS resources easily.
Note: This test case shows the use of cloud security posture management tool (Prisma Cloud) to demonstrate security vulnerabilities from infrastructure build including AWS services such as IAM, AMI, VPC, Security Groups, Subnets and Ec2 instance configurations.


Prerequisites

Before you begin, ensure that you have the following:

    1.    AWS Account: An active AWS account with sufficient privileges.

    2.    AWS CLI: Install and configure the AWS Command Line Interface (CLI) on your local machine.

    3.    IAM Permissions: Ensure that the AWS user/role you are using has sufficient permissions to create and manage resources like EC2, VPC, subnets, etc.

    4.    Terraform : If you are using Terraform for infrastructure provisioning, install Terraform on your local machine.



Install AWS CLI


# For macOS

brew install awscli


# For Linux


    $ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"


    $ sudo yum remove awscli


    $ unzip awscliv2.zip


    $ sudo ./aws/install


Configure AWS CLI Login Using AWS Access Credentials (Using Windows Command Prompt)


     aws configure

     AWS Access Key ID [****************4Q3O]:

     AWS Secret Access Key [****************RAG5]:

     Default region name [us-east-1]:

     Default output format [json]:


Install Terraform (optional)


Follow the instructions in the Terraform installation guide for your operating system.


Infrastructure Components


1. VPC (Virtual Private Cloud)


A custom VPC is created with both public and private subnets. The VPC setup includes:

    •    CIDR Block: 10.0.0.0/16

    •    Two Subnets:

    •    Public subnet: 10.0.1.0/24

    •    Private subnet: 10.0.2.0/24



2. EC2 Instances


The EC2 instance configuration includes:

    •    Instance type: t2.micro (or another instance type as per your requirement)

    •    AMI: A default Amazon Linux 2 AMI or custom AMI

    •    SSH Key Pair for secure access to the instance

    •    User-data scripts for automatic configuration


3. Security Groups


A security group is defined to allow:

    •    SSH (port 22) for the EC2 instances

    •    HTTP (port 80) and HTTPS (port 443) for web servers, if necessary


4. Network Interfaces (ENI)


Elastic Network Interfaces (ENIs) are configured for attaching to EC2 instances for network connectivity. You can add multiple ENIs for better network isolation or for enabling multi-interface EC2 instances.


5. Route Tables


A route table is configured for proper routing within the VPC. The route table includes:


    •    A default route to the internet gateway for public subnets.


    •    A private route table for the private subnet, which may use a NAT Gateway for internet access.




Quick Start


Using CloudFormation


    1.    Navigate to the AWS Management Console.


    2.    Go to the CloudFormation service.


    3.    Create a new stack using the provided CloudFormation template (e.g., aws_infrastructure.yml).


    4.    Follow the steps to configure parameters (VPC CIDR, instance type, etc.).


    5.    Once the stack creation completes, you will have a fully provisioned infrastructure with EC2 instances and network interfaces.




Using Terraform    # Using Terraform For My AWS Infra Build


    1.    Clone this repository to your local machine.


        git clone https://github.com/your-repo/Terraform-aws-repo5.git


        cd Terraform-aws-repo5


    2.    Initialize Terraform.


        terraform init


    3.    Review the Terraform configuration.


        terraform plan



    4.    Apply the configuration to create the infrastructure.


        terraform apply



    5.    Confirm the changes and wait for Terraform to provision the resources.


    6.    Once complete, the EC2 instance(s) and network interfaces will be provisioned.



Directory Structure


/aws-infrastructure

     ├── cloudformation

     │   ├── aws_infrastructure.yml

     ├── terraform

     │   ├── main.tf

     │   ├── variables.tf

     │   └── outputs.tf

     └── scripts

     ├── user_data.sh


Customization


You can customize the infrastructure by modifying the following parameters:


    •    VPC CIDR Block: Modify the CIDR block to match your network requirements.

    •    EC2 Instance Type: Change the instance type in the CloudFormation or Terraform configuration.

    •    Security Group Rules: Adjust the security group to open additional ports or restrict access based on your needs.


Using Virtual Studio Code with Prisma cloud plugin to capture infrastructure loopholes and recommendations as show below.

#Screenshots

![image](https://github.com/user-attachments/assets/88a5afe9-3774-4815-a62c-5e824f15e96e)
![image](https://github.com/user-attachments/assets/bd927c29-24f5-4f85-b739-50cca3043ff8)
![image](https://github.com/user-attachments/assets/6146eddd-bb1d-4262-ae19-d300fc94f59f)
![image](https://github.com/user-attachments/assets/e8b02825-b029-4ecb-9dc4-2b5154e4d184)
![image](https://github.com/user-attachments/assets/583cb9f4-c155-4b29-a3a5-ebd876f29804)
![image](https://github.com/user-attachments/assets/b3454dfd-0840-4fb3-8a10-fef63f8d19c8)

#Clean Up

To avoid incurring extra charges, be sure to delete the resources when you’re done using them.

Using CloudFormation

    1.    Go to the AWS Management Console.

    2.    Navigate to the CloudFormation service.

    3.    Select the stack you created.

    4.    Click on Delete.


Using Terraform

To destroy the infrastructure created by Terraform, run:

    terraform destroy

Confirm the destruction when prompted and Terraform will delete all resources.

Troubleshooting

    •    Ensure that your AWS credentials have sufficient permissions to create and manage EC2, VPC, and other necessary services.

    •    If the EC2 instances fail to launch, check the security group and IAM role permissions.

    •    If you encounter issues with the network interface, ensure that it is correctly attached to the EC2 instance and has proper routing configured.


Contributing

If you find any issues or want to contribute improvements, feel free to submit a pull request or open an issue in the repository.

License

This project is licensed under the MIT License - see the LICENSE file for details.

