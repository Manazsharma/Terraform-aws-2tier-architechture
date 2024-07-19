2-Tier-Architecture Project with Terraform and AWS
--------------------------------------------------

This project showcases implementing a scalable and resilient 2-tier architecture using Terraform and AWS. Leveraging the power of infrastructure as code, this setup provides a solid foundation for deploying web applications with high availability and fault tolerance.

<h2> Workflow </h2>

![Workflow Diagram](https://imgs.search.brave.com/icnT9uKJMd8CwMdi52WewRNmExyM46MVt9ITzFj_oJ4/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9hc3Nl/dHMubnVtZXJpY2Fp/ZGVhcy5jb20vMjAy/My8wNS9EZXBsb3lp/bmctV29yZFByZXNz/LW9uLWEtMi1UaWVy/LUFXUy1BcmNoaXRl/Y3R1cmUtRGlhZ3Jh/bS5wbmc)

### Features

*   **Tier 1: Web Tier**
    
    *   EC2 instances provisioned in public subnets
        
    *   Auto Scaling Group for handling the dynamic workload
        
    *   Load Balancer for distributing traffic and ensuring high availability
        
    *   Security Groups to control inbound and outbound traffic
        
*   **Tier 2: Database Tier**
    
    *   RDS MySQL instance in a private subnet
        
    *   Secure network access using security groups
        

Prerequisites
-------------

To use this project, you need to have the following prerequisites:

*   AWS account with necessary permissions
    
*   Terraform installed on your local machine
    

Getting Started
---------------

1.  Clone this repository to your local machine.

2.  Configure your AWS credentials by setting the environment variables or using the AWS CLI.
    
3.  Initialize the Terraform project.
    

`   $ terraform init   `

4.  Review the execution plan.
    

` $ terraform plan  `

5.  Deploy the architecture.
    

  `  $ terraform apply  ` 

1.  Confirm the deployment by typing yes when prompted.
    

Cleanup
-------

*   To clean up and destroy the infrastructure created by this project, run the following command:
    
`   $ terraform destroy   `

Note: Be cautious as this action cannot be undone.

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.
