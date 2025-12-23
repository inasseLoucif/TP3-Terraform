# **TP Terraform **

Ce TP a consisté à créer une infrastructure AWS scalable avec Terraform utilisant un Auto Scaling Group, Application Load Balancer et instances EC2 automatisées. Le trigramme "ILF" a été utilisé pour toutes les ressources. Voici le déroulement détaillé des étapes de développement et déploiement.

## **Étape 1 : Préparation Environnement**

Configuration AWS CLI et console en anglais (US). Création des fichiers Terraform suivants :

* **providers.tf** : Provider AWS région us-east-1

* **variables.tf** : trigramme="ILF", AMI="ami-0c02fb55956c7d316" (Amazon Linux 2), desired\_capacity=2

* **main.tf** : Infrastructure complète (VPC, subnets, IGW, RT, SGs, ALB, TG, Listener, Launch Template, ASG)

* **userdata.sh** : Script bash installant httpd et générant index.html dynamique avec ID instance \+ trigramme

* **terraform.tfvars** : trigramme \= "ILF"

Commandes : `terraform init` puis `terraform validate`.

## **Étape 2 : Planification et Déploiement Initial**

`terraform plan`

**Résultat :** 15 ressources prévues (1 VPC, 2 subnets publics, 1 IGW, 1 RT+2 associations, 2 SGs, 1 ALB, 1 TG, 1 Listener, 1 LT, 1 ASG).

text  
`terraform apply`

**Déploiement réussi** créant l'infrastructure avec 2 instances EC2 (desired\_capacity=2) dans l'ASG "ILF-asg".

## **Étape 3 : Architecture Créée**

L'infrastructure respecte le schéma demandé :

* **VPC** : ILF\_vpc (10.0.0.0/16)

* **Subnets publics** : ILF\_public\_a (us-east-1a), ILF\_public\_b (us-east-1b)

* **Application Load Balancer** : ILF-alb exposé port 80

* **Target Group** : ILF-tg avec health checks HTTP/200

* **Auto Scaling Group** : ILF-asg (min=1, max=3, desired=2) sur Launch Template ILF-lt-

* **Security Groups** : ILF\_alb\_sg (HTTP internet→ALB), ILF\_inst\_sg (HTTP ALB→instances)

## **Étape 4 : Test Scaling Prévu**

`terraform apply -var="desired_capacity=3"`

Cette commande augmentera l'ASG à 3 instances. Les nouvelles instances s'enregistreront automatiquement dans le Target Group via health checks ELB.

## **Étape 5 : Vérifications Prévue**

* Accès ALB DNS pour voir rotation IDs instances \+ "Trigramme: ILF"

* Console AWS : ASG, Target Group, ALB pour valider cibles saines

* Tests scaling up/down via modification desired\_capacity

## **Étape 6 : Nettoyage**

`terraform destroy`

## **Fichiers Sources**

Tous les fichiers Terraform sont prêts pour dépôt Git sur Moodle :

`main.tf, variables.tf, providers.tf, terraform.tfvars, userdata.sh, .terraform.lock.hcl, .gitignore`

