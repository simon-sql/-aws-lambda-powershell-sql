## INSTALL AWS SDK
FROM public.ecr.aws/lambda/provided:al2023 AS module-files
ARG ARTIFACTS_DIR=/opt
RUN dnf install unzip -y
RUN dnf install libicu -y
RUN dnf install krb5-workstation -y

COPY ./sqlserver.22.2.0.nupkg $ARTIFACTS_DIR/sqlserver.nupkg
RUN mkdir -p $ARTIFACTS_DIR/modules

# Extract SqlServer module
RUN unzip $ARTIFACTS_DIR/sqlserver.nupkg -d $ARTIFACTS_DIR/modules/SqlServer

RUN rm $ARTIFACTS_DIR/sqlserver.nupkg
