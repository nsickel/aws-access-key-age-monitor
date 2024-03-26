# under construction - project to get started with ruby, not applicable for production environments

## aws access key age monitor

This repo contains a serverless application which is triggered via a cloudwatch cron event to check all IAM access keys of a single AWS account for their age and creates a report if the age reaches a critical state.
welcome.html

### requirements
project was created with the following requirements

- aws sam cli 1.110.0
- ruby runtime 3.2

### run on local machine
Ensure you have a valid env-file like sample-env.json
```bash
cp sample-env.json env.json
```
Run build and test on local machine
```bash
sam build --use-container
sam local invoke AccessKeyAgeMonitorFunction
```

