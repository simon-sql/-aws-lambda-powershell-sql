## INSTALL AWS SDK
FROM public.ecr.aws/lambda/provided:al2023 AS module-files
ARG ARTIFACTS_DIR=/opt
RUN dnf install unzip -y
RUN dnf install libicu -y
RUN dnf install krb5-workstation -y

# Set environment variable for krb5 configuration
ENV KRB5_CONFIG=/etc/krb5.conf

# Copy the custom krb5.conf into the container to overwrite the default
COPY ./krb5.conf /etc/krb5.conf

# Copy the keytab file with appropriate permissions
# COPY ./sqlk.keytab /etc/security/keytabs/sqlk.keytab
# RUN chmod 600 /etc/security/keytabs/sqlk.keytab

#RUN curl -L -o $ARTIFACTS_DIR/AWS.Tools.zip https://sdk-for-net.amazonwebservices.com/ps/v4/latest/AWS.Tools.zip
COPY ./sqlserver.22.2.0.nupkg $ARTIFACTS_DIR/sqlserver.nupkg
RUN mkdir -p $ARTIFACTS_DIR/modules

# Extract SqlServer module
RUN unzip $ARTIFACTS_DIR/sqlserver.nupkg -d $ARTIFACTS_DIR/modules/SqlServer

RUN rm $ARTIFACTS_DIR/sqlserver.nupkg
