# Specify build arguments for AWS account ID and region
ARG AWS_ACCOUNT_ID="0123456789012"
ARG AWS_REGION="eu-west-2"

# Use arguments to build image references
FROM ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/powershell-runtime:latest AS runtime-files
FROM ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/powershell-modules-aws-tools:latest AS module-aws-tools
FROM ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/powershell-modules-sqlserver:latest AS module-sqlserver-files

## Build final image
FROM public.ecr.aws/lambda/provided:al2023

## Copy PowerShell runtime files
COPY --from=runtime-files . /
## Copy Module files
COPY --from=module-aws-tools . /
COPY --from=module-sqlserver-files . /

## Function files
COPY /function/ /var/task
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
ENV KRB5CCNAME=/tmp/krb5cc_ticket

WORKDIR /var/task
ENTRYPOINT [ "/var/runtime/bootstrap" ]
CMD [ "examplehandler.ps1::handler" ]
