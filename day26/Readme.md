### VPC Design and Implementation:

-   Create a VPC

![alt text](image.png)
![alt text](image-1.png)
![alt text](image-2.png)

-   create subnet 2-Private and 2-Public

![alt text](image-11.png)
![alt text](image-12.png)
![alt text](image-13.png)
![alt text](image-14.png)
![alt text](image-15.png)

-   Set up an Internet Gateway to allow internet access for the public subnets.

![alt text](image-16.png)
![alt text](image-17.png)

-   Configure routing tables to enable communication between the subnets, ensuring that the private subnets can only communicate with the public subnets.


![alt text](image-18.png)
![alt text](image-19.png)
![alt text](image-20.png)
![alt text](image-21.png)
![alt text](image-22.png)
![alt text](image-23.png)
![alt text](image-24.png)

-   configure with internet gateway 


![alt text](image-25.png)
![alt text](image-26.png)

-   configure route table to subnet

![alt text](image-27.png)

### vpc structure

![alt text](image-3.png)
![alt text](image-4.png)



### Create and Configure S3 Buckets

![alt text](image-7.png)

### launch ec2 instanace
-   Launch a pair of EC2 instances (t2.micro ONLY) in the public subnets using an Amazon Linux 2 AMI.

![alt text](image-8.png)

-   SSH into the instances and install a web server (Apache or Nginx) along with necessary application dependencies.

![alt text](image-9.png)








