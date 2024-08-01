FROM apache/airflow:2.10.0b1-python3.11

ARG AIRFLOW_VERSION

USER root

# Install OpenJDK 17
RUN apt-get update \
  && apt-get install -y --no-install-recommends openjdk-17-jre-headless wget \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz && \
  tar xvf hadoop-3.3.4.tar.gz && \
  mv hadoop-3.3.4 /opt/hadoop && \
  rm hadoop-3.3.4.tar.gz

# Set environment variables for Spark and Hadoop
ENV SPARK_HOME=/opt/spark
ENV HADOOP_HOME=/opt/hadoop
ENV PATH="$PATH:$SPARK_HOME/bin:$HADOOP_HOME/bin"

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Switch back to the airflow user
USER airflow

# Install Apache Airflow and related packages
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" \
  apache-airflow-providers-apache-spark pyspark


#docker exec -it allaboutspark-spark-master-1 spark-submit jobs/exJob.py
