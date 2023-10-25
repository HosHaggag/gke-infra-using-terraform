<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
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
  <a href="https://github.com/HosHaggag/gke-infra-using-terraform">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">infrastructure on GKE using Terraform</h3>

  <p align="center">
    deploy a Node-JS Application connected with high available MongoDB cluster on GKE using Terraform 
    <br />
    <br />
    <br />
    <a href="https://github.com/HosHaggag/gke-infra-using-terraform">View Demo</a>
    ·
    <a href="https://github.com/HosHaggag/gke-infra-using-terraform">Report Bug</a>
    ·
    <a href="https://github.com/HosHaggag/gke-infra-using-terraform">Request Feature</a>
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
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
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

### Installation

#### Setup Infrastructure:

1. Clone the repo
   ```sh
   git clone https://github.com/HosHaggag/gke-infra-using-terraform
   cd gke-infra-using-terraform
   ```
2. Create Terraform backend state file on GCP
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

#### Deploy Application:

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


to be continued ...
<p align="right">(<a href="#readme-top">back to top</a>)</p>



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
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 


[Kubernetes]: https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white
[LinkedIn]: https://img.shields.io/badge/linkedin-%230077B5.svg?style=for-the-badge&logo=linkedin&logoColor=white
[GitHub]: https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white
[Docker]: https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white
[NodeJS]: https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white
[MongoDB]: https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white
[GoogleCloud]: https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white
[Terraform]: https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white


