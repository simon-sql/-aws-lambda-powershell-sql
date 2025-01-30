# Demo-sqlserver-container-images-shared

Demo application to deploy a PowerShell Lambda function using existing [container image](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html) layers. The container image can be up to 10Gb in size which allows you to build functions larger than the 256MB limit for .zip archive functions. This allows you to include the entire [SqlServer module](https://www.powershellgallery.com/packages/sqlserver/22.2.0), for example.

The build process initially creates three base image layers which makes it easier to share these base layers with multiple functions:

1. PowerShell custom runtime based on ````provided.al2023````. This downloads the specified version of [PowerShell](https://github.com/PowerShell/PowerShell/releases/) and adds the custom runtime files from the [PowerShell-runtime](../../powershell-runtime/) folder.

2. The [AWSTools for PowerShell](https://aws.amazon.com/powershell/) with the entire AWS SDK. You can amend the loaded modules within the Dockerfile to only include specific modules. AWS.Tools.Common is required

3. The [SqlServer module](https://www.powershellgallery.com/packages/sqlserver/22.2.0).

You can then create Lambda functions by importing the three image layers and then adding the function code in the [function](./function) folder.

You build the initial base layers using [Docker Desktop](https://docs.docker.com/get-docker/) and the AWS CLI.

### Pre-requisites

* [Docker Desktop](https://docs.docker.com/get-docker/)
* [AWS Command Line Interface (AWS CLI)](https://aws.amazon.com/cli/)
* [AWS Serverless Application Model Command Line Interface (AWS SAM CLI) ](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html)

1. Clone the repository and change into the example directory

```shell
git clone https://github.com/simon-sql/aws-lambda-powershell-sql
cd aws-lambda-powershell-sql/examples/demo-container-images-shared
```

2. Login to [Amazon Elastic Container Registry (ECR)](https://aws.amazon.com/ecr/) which is used to store the container images. Replace the `<region>` and `<account>` values.
```shell
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account>.dkr.ecr.<region>.amazonaws.com
```

## Build the PowerShell runtime base layer.

1. Change into the `powershell-runtime` directory

```shell
cd powershell-runtime
```
2. Set Enviroment Variables for Account and Region. Replace the `<region>` and `<account>` values.
```shell
export AWS_ACCOUNT_ID=<account>
export AWS_REGION=<region>
```
3. Build the Docker image and push it to the ECR
```shell
./build_df.sh
```

## Build the AWS Tools base layer.

1. Change into the `powershell-modules-aws-tools` directory

```shell
cd ../powershell-modules-aws-tools
```

2. Build the Docker image and push it to the ECR
```shell
./build_df.sh
```

## Build the SqlServer module base layer.

1. Change into the `powershell-modules-sqlserver` directory

```shell
cd ../powershell-modules-sqlserver
```
2. Build the Docker image and push it to the ECR
```shell
./build_df.sh
```

### Build the container image function

1. use `sam build` to build the container image.

```shell
sam build --parameter-overrides AWSAccountID=<account> AWSRegion=<region>
```
### Test the function locally

Once the build process is complete, you can use AWS SAM to test the function locally - modify input.json for your local SQL Server.  Please note this is demo code only and credentials should be retrieved from a secure source eg. AWS Secrets Manager.

```shell
sam local invoke --event events/input.json 
```

This uses a Lambda-like environment to run the function locally and returns the function response, which is the result of `select [name] as [database_name] from sys.databases;'.

![sam local invoke](/img/sam-local-invoke.png)


