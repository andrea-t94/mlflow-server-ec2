# mlflow-server

## Current Infrastructure

[MLflow server](http://ec2-13-59-28-75.us-east-2.compute.amazonaws.com/#/)

- Docker container that launches MLflow with Nginx as server proxy
- Internal Backend with SQlite as DB
- Cronjob to sync Backend in [S3](https://s3.console.aws.amazon.com/s3/buckets/flixtech-primus-dev-mlflow-runs?region=us-east-2&prefix=backend_database/&showversions=false)
- External artifacts root in [S3](https://s3.console.aws.amazon.com/s3/buckets/flixtech-primus-dev-mlflow-runs?region=us-east-2)

## Desired Infrastructure
![MLflow server infra](images/mlflow_server.png)

## How to set up
- launch Linux AMI instance type with relevant Security Groups 3 and 4 ([MLflow server setup](https://wiki.mfb.io/display/CRM/How+to%3A+AD+-+Set+up+EC2+cluster+for+MLflow+and+for+distributed+training+with+Ray+Tune))
- add IAM role to have access on AWS S3
- install git, and clone this repository
```
    sudo yum install git
    sudo git clone <this_repo_url>
```  
- prepare and launch docker
```
    ./prepare_docker.sh
    ./launch_docker.sh
```  
- set up a cron job
```
    sudo service crond start
    crontab -e
```  
- cronjob to include inside the crontab
```
    SHELL=/bin/sh
    PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/ec2-user/.local/bin:/home/ec2-user/bin
    0 1 * * * aws s3 sync /home/ec2-user/data/ s3://flixtech-primus-dev-mlflow-runs/backend_database/
```
    

## Improvements
- add environs in cronjob and launch cronjob with docker seamlessly (optional if no external DB)
- External DB (e.g. Snowflake or RDS)
- SSM to store DB credentials
- you have to manually install git at every run with sudo yum install git, machine with git preinstalled
- docker mlflow serve image stored in a repository
- CI/CD Gitlab pipeline AWS - GitLab

## References
- [Deploy MLflow with docker compose](https://towardsdatascience.com/deploy-mlflow-with-docker-compose-8059f16b6039)
- [Set Up MLflow on AWS EC2 Using Docker, S3, and RDS](https://aws.plainenglish.io/set-up-mlflow-on-aws-ec2-using-docker-s3-and-rds-90d96798e555)
- [Deploying Go App with NGINX + Docker to Amazon EC2](https://medium.com/easyread/deploying-go-app-with-nginx-docker-to-aws-ec2-b33d458918fd)
- [Deploy to AWS using Docker compose](https://medium.com/@umairnadeem/deploy-to-aws-using-docker-compose-simple-210d71f43e67)