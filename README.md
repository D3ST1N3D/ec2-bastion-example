# ec2-bastion-example
## Terraform Setup

This project includes a basic Terraform configuration. The configuration deploys an **EC2 bastion instance** into an existing VPC with public subnets.
## Terraform Prerequisites

Before you can successfully run the Terraform configuration in this project, make sure you have the following in place:

1. **AWS Account** \
   You need an active AWS account with permissions to create and manage EC2 instances, security groups, and related resources.

2. **AWS CLI Configuration** \
   Having the AWS CLI configured ensures your credentials and region settings are properly set. You can do this with:
   ```bash
   aws configure
    ```
   Provide AWS access key, secret key and default region when prompted.

3. **Terraform Installation**\
    Make sure terraform is installed by running the following command
    ```bash
    terraform --version
    ```
    If the command is not found then please consult [terraform installation guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

4. **AWS Key Pair**\
    We will need a key pair to use for accessing the bastion host. One can be created using the aws cli as follows:
    ```bash
    aws ec2 create-key-pair --key-name $KEY_NAME --query 'KeyMaterial' --output text > $KEY_NAME.pem
    ```
    This will create a key pair and add create a file locally with the content needed to connect using this key.
    The `$KEY_NAME` is also provided to the terraform configuration so that it can be setup in the bastion host.

5. **Existing VPC,Subnet and Security Group**\
    We will need to provide the information of an existing VPC by providing its `subnet id` so note that down and provide it to the terraform configuration.
    We will also need a security group that atleast allows ssh (port 22) from the desired IP address to be able to access the bastion host once it is created. Note down the `security group id` as that will also be required by terraform. 

---
### Required Variables

| Variable              | Description                                                                                                                                                                 | Example                         |
|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------|
| **`aws_region`**      | The AWS region where you want to create resources.                                                                                                                         | `"us-east-1"`                   |
| **`ami_id`**          | The Amazon Machine Image (AMI) to use for your EC2 instance.                                                                                                              | `"ami-0123456789abcdef0"`       |
| **`instance_type`**   | The EC2 instance type to create (e.g., t2.micro, t3.medium).                                                                                                               | `"t2.micro"`                    |
| **`subnet_id`**       | The ID of the **public** subnet where this instance will reside.                                                                                                            | `"subnet-01234567"`             |
| **`security_group_id`** | The ID of the security group to attach to the instance. You must allow SSH traffic (port 22) at minimum.                                                                    | `"sg-01234567"`                 |
| **`key_name`**        | The name of an existing AWS key pair, allowing you to SSH into the instance.                                                                                               | `"my-ssh-keypair"`              |

 

- **`aws_region`** ensures Terraform and the AWS provider know where to provision infrastructure.
- **`ami_id`** determines the base operating system for your instance (e.g., Amazon Linux, Ubuntu).
- **`instance_type`** affects performance and pricing.
- **`subnet_id`** specifies where the bastion instance will live (in a **public subnet**).
- **`security_group_id`** controls inbound/outbound traffic (ensure port 22 is open to your IP for SSH).
- **`key_name`** is required for SSH access unless another authentication method is used.

### Usage

1. **Navigate to the Terraform directory**:
   ```bash
   cd terraform/
    ```
2. **Initialize Terraform**
    ``` bash
    terraform inti
    ```
3. **Provide Variables**
    Variables may be supplied using the command line as shown below:
    ```bash
    terraform plan \
        -var="aws_region=us-east-1" \
        -var="ami_id=ami-0123456789abcdef0" \
        -var="instance_type=t2.micro" \
        -var="subnet_id=subnet-01234567" \
        -var="security_group_id=sg-01234567" \
        -var="key_name=my-ssh-keypair"
    ```
    They can also be supplied by creating a `terraform.tfvars` file in the root of the project before running the `terrraform plan` or `apply` commands.
    ```
    # terraform.tfvars file content
    aws_region        = "us-east-1"
    ami_id            = "ami-0123456789abcdef0"
    instance_type     = "t2.micro"
    subnet_id         = "subnet-01234567"
    security_group_id = "sg-01234567"
    key_name          = "my-ssh-keypair"
    ```
    ``` bash
    terraform plan
    # or 
    terraform apply
    ```


    
