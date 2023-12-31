﻿<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/HosHaggag/gke-infra-using-terraform.git">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">infrastructure on GKE using Terraform</h3>

  <p align="center">
    deploy a Node-JS Application connected with high available MongoDB cluster on GKE using Terraform 
    <br />
    <br />
    <br />
    <a href="#if-you-want-to-test-the-application-you-can-use-the-following-steps">View Demo</a>
    ·
    <a href="https://github.com/HosHaggag/gke-infra-using-terraform/issues/new">Report Bug</a>
    ·
    <a href="http://185.69.166.176/">buy me a Tea ☕</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        </ul>
    <li><a href="#installation">Installation</a>
        <ul>
            <li><a href="#setup-infrastructure">Setup Infrastructure</a></li>
            <li><a href="#deploy-application">Deploy Application</a></li>
          </ul>          
    </li>    
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contact">Contact</a></li>
    </li>
    

  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)


Here's our structure grantee high availability, single point of failure, scalability and security as well for our application and database.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* ![Docker][Docker]
* ![Kubernetes][Kubernetes]
* ![GoogleCloud][GoogleCloud]
* ![Terraform][Terraform]
* ![NodeJS][NodeJS]
* ![MongoDB][MongoDB]



<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is detailed steps to deploy the application on GKE using Terraform and Kubernetes, including tricks in the middle.

### Prerequisites

* Terraform
* GCP account
* GCP project
* GCP CLI

## Installation

### Setup Infrastructure:

1. Clone the repo
   ```sh
   git clone https://github.com/HosHaggag/gke-infra-using-terraform
   cd gke-infra-using-terraform
   ```
2. Create Terraform backend state file on GCP ( optional )
  - Create a bucket on GCP
  - Name an object in the bucket called `terraform/state/terraform.tfstate`
  - assign the bucket name `backend.tf` file


3. Setup infrastructure using Terraform
   ```sh
    terraform init
    terraform plan
    terraform apply --auto-approve
   ```

Now all the infrastructure is ready, let's deploy our application on it.


<br>

### Deploy Application:

1. SSH to the bastion host using GCP Console or GCP CLI
   ```sh
   gcloud compute ssh managment-instance --zone us-central1-a
   ```

2. Configure kubectl to connect to the cluster
   ```sh
   gcloud container clusters get-credentials workload-cluster --region us-east1
   ```
   install kubectl if not installed
   ```sh
   gcloud components install kubectl --quiet
   ```
3. Install and Dockerize the applications
   ```sh
    git clone https://github.com/HosHaggag/gke-infra-using-terraform.git
    cd gke-infra-using-terraform/mongodb
    sudo docker build -t us-central1-docker.pkg.dev/<Project_ID>/my-nodejs-repo/mongodb:1.0.0  .
    sudo docker push us-central1-docker.pkg.dev/<Project_ID>/my-nodejs-repo/mongodb:1.0.0
    kubectl apply -f storage-class.yaml
    kubectl apply -f mongodb-statefulset.yaml
   ```

     you should see something like this

  [![rs.status Screen Shot][svcMongoDB]](https://example.com)

   In case you face a premission issue, you can use the following command to grant the bastion host the permission to push images to the container registry
   ```sh
   gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-central1-docker.pkg.dev
   ```

   For the NodeJS application we will use the same steps

    ```sh
      cd ../nodejs
      docker build -t us-central1-docker.pkg.dev/<Project_ID>/my-nodejs-repo/nodejs:1.0.0  .
      docker push us-central1-docker.pkg.dev/<Project_ID>/my-nodejs-repo/nodejs:1.0.0
      kubectl apply -f deployment.yaml
      kubectl apply -f load-balancer.yaml
    ```


4. Configure Database replica set
   ```sh
   kubectl exec -it mongodb-0 -- mongosh
   ```
   ```sh
   use admin
   ```
   ```sh
   rs.initiate( {
      _id : "rs0",
      members: [
         { _id: 0, host: "mongodb-0.mongodb-service.default.svc.cluster.local:27017" },
         { _id: 1, host: "mongodb-1.mongodb-service.default.svc.cluster.local:27017" },
         { _id: 2, host: "mongodb-2.mongodb-service.default.svc.cluster.local:27017" }
      ]
   })
   ```
   ```sh
    db.createUser(
         {
           user: "admin",
           pwd: "password",
           roles: [
             { role: "readWrite" }
           ]
         }
       );
   ```

   Now if you call ```rs.status()``` you will see the replica set status

   you should see something like this
   [![rs.status Screen Shot][rsstatus]](https://example.com)
   
   [![rs.status Screen Shot][rsStatus_1]](https://example.com)
   [![rs.status Screen Shot][rsStatus_2]](https://example.com)


   
  
<br>
   You can Now exit the mongo shell

   ```sh
   exit
   ```

Congratulations 🎉
Now all sat, you can access the application using the URL you got from step 4.



<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Usage

 Call the application URL from the load balancer service
 
   ```sh
   curl "$(kubectl get svc nodejs-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
   ```


#### End of installation document
<hr>

#### If you want to test the application, you can use the following steps

<hr>
<a name="demo"></a>

## Demo if ```PRIMARY``` pod is down use case

1. Delete the primary pod
   ```sh
   kubectl delete pod mongodb-0
   ```
   [![rs.status Screen Shot][delpod]](https://example.com)

2. Check the replica set status
    ```sh
    kubectl exec -it mongodb-1 -- mongosh
    ```
    ```sh
    rs.status()
    ```
    [![rs.status Screen Shot][afterdeletestatus]](https://example.com)
we can see that the pod mongodb-1 is now the primary pod
and there is no data loss.
<be>

3. Check the application status

    ```sh
    curl "$(kubectl get svc nodejs-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
    ```

    you should see something like this
   
    [![rs.status Screen Shot][finalresult]](https://example.com)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Thank you for your time 🙏

<hr>

## Contact

[![LinkedIn][LinkedIn]](https://www.linkedin.com/in/hossam-haggag/)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/HosHaggag/gke-infra-using-terraform.svg?style=for-the-badge
[contributors-url]: https://github.com/HosHaggag/gke-infra-using-terraform/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/HosHaggag/gke-infra-using-terraform.svg?style=for-the-badge
[forks-url]: https://github.com/HosHaggag/gke-infra-using-terraform/network/members
[stars-shield]: https://img.shields.io/github/stars/HosHaggag/gke-infra-using-terraform.svg?style=for-the-badge
[stars-url]: https://github.com/HosHaggag/gke-infra-using-terraform/stargazers
[issues-shield]: https://img.shields.io/github/issues/HosHaggag/gke-infra-using-terraform.svg?style=for-the-badge
[issues-url]: https://github.com/HosHaggag/gke-infra-using-terraform/issues
[license-shield]: https://img.shields.io/github/license/HosHaggag/gke-infra-using-terraform.svg?style=for-the-badge
[license-url]: https://github.com/HosHaggag/gke-infra-using-terraform/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/hossam-haggag/
[product-screenshot]: images/project-structure.png
[rsStatus_1]: images/rsstatus_1.png
[rsStatus_2]: images/rsstatus_2.png
[rsStatus]: images/rsstatus.png
[svcMongoDB]: images/svcmongo.png
[delpod]: images/delpod.png
[afterdeletestatus]: images/afterdeletestatus.png
[getall]: images/getall.png
[finalresult]: images/finalresult.png



[Kubernetes]: https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white
[LinkedIn]: https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white
[GitHub]: https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white
[Docker]: https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white
[NodeJS]: https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white
[MongoDB]: https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white
[GoogleCloud]: https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white
[Terraform]: https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white


